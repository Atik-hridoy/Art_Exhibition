import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';

class CheckOutController extends GetxController{
  bool isTermsAndCondition=false;
  bool isPlacingOrder = false;

  // Shipping info state
  String name = AppString.shippingNameSample;
  String phone = AppString.shippingPhoneSample;
  String address = AppString.shippingAddressSample;
  final double shippingCharge = 100;
  final String paymentMethod = 'card';

  // Text controllers for edit dialog
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController noteCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    nameCtrl.text = AppString.shippingNameSample;
    phoneCtrl.text = AppString.shippingPhoneSample;
    addressCtrl.text = AppString.shippingAddressSample;
  }

  void updateTermsAndCondition(){
    isTermsAndCondition=!isTermsAndCondition;
    update();
  }

  void saveShippingEdits(){
    name = nameCtrl.text.trim().isEmpty ? AppString.shippingNameSample : nameCtrl.text.trim();
    phone = phoneCtrl.text.trim().isEmpty ? AppString.shippingPhoneSample : phoneCtrl.text.trim();
    address = addressCtrl.text.trim().isEmpty ? AppString.shippingAddressSample : addressCtrl.text.trim();
    nameCtrl.text = name;
    phoneCtrl.text = phone;
    addressCtrl.text = address;
    update();
  }

  Future<void> placeOrder({required String artId, required num artPrice}) async {
    if (artId.isEmpty) {
      Utils.errorSnackBar('Missing art', 'Unable to determine artwork id.');
      return;
    }

    if (!isTermsAndCondition) {
      Utils.errorSnackBar('Terms & Conditions', 'Please agree to the terms before placing order.');
      return;
    }

    isPlacingOrder = true;
    update();

    final double priceValue = artPrice.toDouble();
    final double totalPrice = priceValue + shippingCharge;

    final body = {
      'artId': artId,
      'price': priceValue,
      'shippingCharge': shippingCharge,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
      'additionalNote': noteCtrl.text.trim(),
      'shippingAddress': {
        'name': name,
        'phone': phone,
        'address': address,
      }
    };

    try {
      final response = await ApiService.post(ApiEndPoint.order, body: body);
      if (response.statusCode == 200) {
        final responseData = response.data;
        final dynamic dataField = responseData['data'];
        String? checkoutUrl;
        String? successUrl;
        if (dataField is String && dataField.isNotEmpty) {
          checkoutUrl = dataField;
        } else if (dataField is Map) {
          final dynamic directUrl = dataField['url'] ?? dataField['paymentUrl'] ?? dataField['redirectUrl'];
          if (directUrl is String && directUrl.isNotEmpty) {
            checkoutUrl = directUrl;
          }

          final dynamic successField = dataField['successUrl'] ??
              dataField['successURL'] ??
              dataField['success'] ??
              dataField['success_redirect'];
          if (successField is String && successField.isNotEmpty) {
            successUrl = successField;
          }
        }

        if (checkoutUrl != null && checkoutUrl.isNotEmpty) {
          final Map<String, dynamic> args = {'url': checkoutUrl};
          if (successUrl != null && successUrl.isNotEmpty) {
            args['successUrl'] = successUrl;
          }
          Get.toNamed(
            AppRoutes.paymentCheckoutWebView,
            arguments: args,
          );
        } else {
          Utils.successSnackBar('Order placed', 'Your order has been placed successfully.');
          Get.offNamed(AppRoutes.paymentConfirmationScreen);
        }
      } else {
        Utils.errorSnackBar('Order failed', response.message);
      }
    } catch (e) {
      Utils.errorSnackBar('Order failed', e.toString());
    } finally {
      isPlacingOrder = false;
      update();
    }
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    noteCtrl.dispose();
    super.onClose();
  }
}