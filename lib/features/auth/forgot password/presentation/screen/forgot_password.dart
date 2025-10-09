import 'package:flutter/material.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../utils/constants/app_string.dart';
import '../../../../../utils/helpers/other_helper.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (controller) => Scaffold(
        /// App Bar Section

        /// body section
        body: Stack(
          children: [
            Opacity(
              opacity: 0.03,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.splashBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    35.height,
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios, color: AppColors.textFiledColor),
                    ),

                    90.height,

                    Center(
                      child: CommonImage(
                        height: 80,
                        width: 80,
                        fill: BoxFit.cover,
                        imageSrc: AppImages.logo,
                      ).center,
                    ),

                    Center(
                      child: CommonText(
                        top: 32,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                        text: AppString.forgotPassword,
                      ),
                    ),
                    Center(
                      child: CommonText(
                        top: 10,
                        left: 20,
                        right: 20,
                        maxLines: 3,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyClr,
                        text: AppString.forgotPasswordDes,
                      ),
                    ),

                    /// forget password take email for reset Password
                    CommonText(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.titleColor,

                      text: AppString.email,
                      bottom: 8,
                      top: 32,
                    ),
                    CommonTextField(
                      borderColor: AppColors.normalGray2,
                      controller: controller.emailController,

                      hintText: AppString.enterYourEmail,
                      validator: OtherHelper.emailValidator,
                    ),
                    32.height,
                    CommonButton(
                      titleText: AppString.confirm,
                      isLoading: controller.isLoadingEmail,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.forgotPasswordRepo();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        /// Bottom Navigation Bar Section
      ),
    );
  }
}
