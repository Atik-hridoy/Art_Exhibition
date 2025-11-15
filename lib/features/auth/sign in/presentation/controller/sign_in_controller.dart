import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/services/storage/storage_services.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:tasaned_project/utils/log/app_log.dart';
import '../../../../../config/route/app_routes.dart';

class SignInController extends GetxController {
  /// Sign in Button Loading variable
  bool isLoading = false;

  bool isRemember = false;

  /// Sign in form key , help for Validation
  final formKey = GlobalKey<FormState>();

  /// email and password Controller here
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadRememberedCredentials();
  }

  /// Load remembered credentials if available
  void _loadRememberedCredentials() {
    if (LocalStorage.rememberMe) {
      final credentials = LocalStorage.getRememberedCredentials();
      emailController.text = credentials['email'] ?? '';
      passwordController.text = credentials['password'] ?? '';
      isRemember = LocalStorage.rememberMe;
      update();
    }
  }

  //================isRemember Toggle============

  isRememberToggle() {
    isRemember = !isRemember;
    update();
  }

  /// Sign in Api call here

  Future<void> signInUser() async {
    if (!formKey.currentState!.validate()) return;

    // return;
    try {
      isLoading = true;
      update();

      Map<String, String> body = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var response = await ApiService.post(
        ApiEndPoint.signIn,
        body: body,
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        var data = response.data;

        // Save remember me credentials if enabled
        await LocalStorage.saveRememberMeCredentials(
          email: emailController.text,
          password: passwordController.text,
          rememberMe: isRemember,
        );

        // Save login session with all user data
        await LocalStorage.saveLoginSession(
          token: data['data']['token'] ?? '',
          userId: data['data']["user"]["_id"] ?? '',
          userImage: data['data']["user"]["profileImage"] ?? '',
          userName: data['data']["user"]["name"] ?? '',
          userEmail: data['data']["user"]["email"] ?? '',
          userRole: data['data']["user"]["role"] ?? '',
          enableAutoLogin: true,
        );

        // Show success message
        Utils.successSnackBar('Success', 'Login successful! Welcome back.');

        // Navigate to home screen
        Get.offAllNamed(AppRoutes.userHomeScreen);

        // Clear form only if not remembering credentials
        if (!isRemember) {
          emailController.clear();
          passwordController.clear();
        }
      } else {
        appLog("❤️ Value OF Response ${response.data}");
        Get.snackbar(response.statusCode.toString(), response.message);
      }

      isLoading = false;
      update();
    } catch (e) {
      Utils.errorSnackBar('Error', e.toString());
    }
  }
}
