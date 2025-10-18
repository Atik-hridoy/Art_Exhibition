import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/services/storage/storage_keys.dart';
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
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? 'ssmd.bayzid1998@gmail.com' : '',
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? '@bc12345' : "",
  );

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

        LocalStorage.token = data['data']['token'];
        LocalStorage.userId = data['data']["user"]["_id"];
        LocalStorage.myImage = data['data']["user"]["profileImage"];
        LocalStorage.myName = data['data']["user"]["name"];
        LocalStorage.myRoll = data['data']["user"]["role"];
        LocalStorage.myEmail = data['data']["user"]["email"];
        LocalStorage.isLogIn = true;

        LocalStorage.setBool(LocalStorageKeys.isLogIn, LocalStorage.isLogIn);
        LocalStorage.setString(LocalStorageKeys.token, LocalStorage.token);
        LocalStorage.setString(LocalStorageKeys.userId, LocalStorage.userId);
        LocalStorage.setString(LocalStorageKeys.myRoll, LocalStorage.myRoll);
        LocalStorage.setString(LocalStorageKeys.myImage, LocalStorage.myImage);
        LocalStorage.setString(LocalStorageKeys.myName, LocalStorage.myName);
        LocalStorage.setString(LocalStorageKeys.myEmail, LocalStorage.myEmail);

        Get.offAllNamed(AppRoutes.userHomeScreen);

        emailController.clear();
        passwordController.clear();
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
