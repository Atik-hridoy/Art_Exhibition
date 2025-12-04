import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';

class PaymentCheckoutWebViewScreen extends StatefulWidget {
  const PaymentCheckoutWebViewScreen({super.key});

  @override
  State<PaymentCheckoutWebViewScreen> createState() => _PaymentCheckoutWebViewScreenState();
}

class _PaymentCheckoutWebViewScreenState extends State<PaymentCheckoutWebViewScreen> {
  late final WebViewController _webViewController;
  late final String checkoutUrl;
  late final String successUrl;
  double _progress = 0;
  bool _isUrlValid = true;
  bool _hasRedirected = false;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments ?? {};
    checkoutUrl = arguments['url'] ?? '';
    successUrl = arguments['successUrl'] ?? '';
    _isUrlValid = checkoutUrl.isNotEmpty && Uri.tryParse(checkoutUrl)?.hasAbsolutePath == true;

    if (_isUrlValid) {
      _webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.transparent)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (progress) {
              setState(() => _progress = progress / 100);
            },
            onNavigationRequest: (request) {
              if (_shouldCompleteCheckout(request.url)) {
                _redirectToConfirmation();
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onPageFinished: (url) {
              if (_shouldCompleteCheckout(url)) {
                _redirectToConfirmation();
              }
            },
          ),
        )
        ..loadRequest(Uri.parse(checkoutUrl));
    }
  }

  bool _shouldCompleteCheckout(String url) {
    if (_hasRedirected) return false;
    if (successUrl.isEmpty) return false;
    final normalizedUrl = url.trim().toLowerCase();
    final normalizedSuccess = successUrl.trim().toLowerCase();
    return normalizedUrl.startsWith(normalizedSuccess);
  }

  void _redirectToConfirmation() {
    if (_hasRedirected) return;
    _hasRedirected = true;
    Get.offAllNamed(AppRoutes.paymentConfirmationScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          text: AppString.checkout,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 23, color: AppColors.titleColor),
        ),
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: _progress > 0 && _progress < 1
              ? LinearProgressIndicator(
                  value: _progress,
                  minHeight: 2,
                  color: AppColors.primaryColor,
                  backgroundColor: AppColors.normalGray2,
                )
              : const SizedBox.shrink(),
        ),
      ),
      body: _isUrlValid
          ? WebViewWidget(controller: _webViewController)
          : Center(
              child: CommonText(
                text: 'Invalid payment link provided.',
                color: AppColors.bodyClr,
              ),
            ),
    );
  }
}
