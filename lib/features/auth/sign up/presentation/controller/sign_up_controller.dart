import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/storage/storage_keys.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../../utils/app_utils.dart';

class SignUpController extends GetxController {
  final signUpFormKey = GlobalKey<FormState>();

  bool isPopUpOpen = false;
  bool isLoading = false;
  bool isLoadingVerify = false;

  Timer? _timer;
  int start = 0;

  String time = "";

  String selectRole = LocalStorage.myRoll;
  String? image;

  static SignUpController get instance => Get.put(SignUpController());

  TextEditingController nameController = TextEditingController(
    text: kDebugMode ? "S M Nasim Ahmed" : "",
  );
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? "exkakpg@fexbox.org" : '',
  );

  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );
  TextEditingController confirmPasswordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );

  TextEditingController otpController = TextEditingController();

  var selectedRole = '';

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  signUpUser() async {
    if (!signUpFormKey.currentState!.validate()) return;
    isLoading = true;
    update();
    Map<String, String> body = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "role": selectRole,
    };

    var response = await ApiService.post(ApiEndPoint.signUp, body: body);

    if (response.statusCode == 200) {
      LocalStorage.setString(LocalStorageKeys.myEmail, emailController.text);
      Get.toNamed(AppRoutes.verifyUser);
    } else {
      print(LocalStorage.myRoll);
      Utils.errorSnackBar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    start = 180; // Reset the start value
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start > 0) {
        start--;
        final minutes = (start ~/ 60).toString().padLeft(2, '0');
        final seconds = (start % 60).toString().padLeft(2, '0');

        time = "$minutes:$seconds";

        update();
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> verifyOtpRepo() async {
    isLoadingVerify = true;
    update();
    Map<String, dynamic> body = {
      "email": emailController.text,
      "oneTimeCode": int.tryParse(otpController.text) ?? 0,
    };
    var response = await ApiService.post(ApiEndPoint.verifyEmail, body: body);

    if (response.statusCode == 200) {
      // Check if response contains login data (token, user info)
      var data = response.data;
      
      if (data['data'] != null && data['data']['token'] != null) {
        // Auto-login after successful signup verification
        await LocalStorage.saveLoginSession(
          token: data['data']['token'] ?? '',
          userId: data['data']["user"]["_id"] ?? '',
          userImage: data['data']["user"]["profileImage"] ?? '',
          userName: data['data']["user"]["name"] ?? nameController.text,
          userEmail: data['data']["user"]["email"] ?? emailController.text,
          userRole: data['data']["user"]["role"] ?? selectRole,
          enableAutoLogin: true,
        );

        // Save credentials for remember me (default enabled for new users)
        await LocalStorage.saveRememberMeCredentials(
          email: emailController.text,
          password: passwordController.text,
          rememberMe: true,
        );

        Utils.successSnackBar('Success', 'Account verified! Welcome to Tasaneed.');
        
        // Navigate directly to home screen
        Get.offAllNamed(AppRoutes.userHomeScreen);
      } else {
        // If no auto-login data, go to account verified screen
        Get.toNamed(AppRoutes.accountVerifiedScreen);
      }
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoadingVerify = false;
    update();
  }

  Future<void> resendOtpRepo() async {
    isLoadingVerify = true;
    update();
    Map<String, dynamic> body = {"email": emailController.text};
    var response = await ApiService.post(ApiEndPoint.resendOtp, body: body);

    if (response.statusCode == 200) {
      startTimer();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
  }
}
