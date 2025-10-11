import 'package:flutter/material.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../sign in/presentation/widgets/continue_with_google.dart';
import '../controller/sign_up_controller.dart';
import '../../../../../utils/constants/app_string.dart';
import '../widget/already_accunt_rich_text.dart';
import '../widget/sign_up_all_filed.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Body Section Starts Here
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: controller.signUpFormKey,
              child: Column(
                children: [
                  50.height,
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios, color: AppColors.black),
                  ).start,

                  Center(
                    child: CommonImage(
                      fill: BoxFit.cover,
                      height: 120,
                      width: 120,
                      imageSrc: AppImages.logo,
                    ).center,
                  ),

                  32.height,

                  CommonText(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.title2,
                    text: AppString.createYourAccount,
                  ),

                  16.height,
                  CommonText(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    maxLines: 2,
                    color: AppColors.bodyClr,
                    text: AppString.nannyInformationDes,
                  ),

                  /// All Text Filed here
                  SignUpAllField(controller: controller),

                  25.height,

                  /// Submit Button Here
                  CommonButton(
                    buttonRadius: 60,
                    titleText: AppString.continuess,
                    isLoading: controller.isLoading,
                    onTap: controller.signUpUser,
                  ),
                  25.height,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 1, width: 100.w, color: AppColors.stroke),

                      CommonText(
                        left: 16,

                        right: 16,
                        fontSize: 12,
                        color: AppColors.bodyClr,
                        fontWeight: FontWeight.w400,
                        text: AppString.or,
                      ),

                      Container(height: 1, width: 100.w, color: AppColors.stroke),
                    ],
                  ),

                  15.height,

                  ContinueWithGoogle(),
                  20.height,

                  ///  Sign In Instruction here
                  const AlreadyAccountRichText(),
                  30.height,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
