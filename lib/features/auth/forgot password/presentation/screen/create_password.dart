import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/extensions/extension.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/constants/app_string.dart';
import '../../../../../utils/helpers/other_helper.dart';

class CreatePassword extends StatelessWidget {
  CreatePassword({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Body Section starts here
      body: GetBuilder<ForgetPasswordController>(
        builder: (controller) {
          return Stack(
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
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.textFiledColor,
                        ),
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

                      32.height,
                      CommonText(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,

                        text: AppString.resetPass,
                      ).center,

                      CommonText(
                        fontSize: 12,
                        left: 12,
                        right: 12,
                        top: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyClr,
                        maxLines: 3,

                        text: AppString.resetPassDes,
                      ),

                      32.height,

                      /// New Password here
                      CommonText(
                        fontSize: 14,
                        color: AppColors.titleColor,
                        fontWeight: FontWeight.w700,
                        text: AppString.newPassword,
                        bottom: 8,
                      ),
                      CommonTextField(
                        borderColor: AppColors.normalGray2,
                        controller: controller.passwordController,

                        hintText: AppString.password,
                        isPassword: true,
                        validator: OtherHelper.passwordValidator,
                      ),

                      /// Confirm Password here
                      CommonText(
                        fontSize: 14,
                        color: AppColors.titleColor,
                        top: 17,
                        fontWeight: FontWeight.w700,
                        text: AppString.confirmPassword,
                        bottom: 8,
                      ),
                      CommonTextField(
                        borderColor: AppColors.normalGray2,

                        controller: controller.confirmPasswordController,

                        hintText: AppString.confirmPassword,
                        validator: (value) => OtherHelper.confirmPasswordValidator(
                          value,
                          controller.passwordController,
                        ),
                        isPassword: true,
                      ),
                      64.height,

                      /// Submit Button here
                      CommonButton(
                        titleText: AppString.updatePassword,
                        isLoading: controller.isLoadingReset,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            controller.resetPasswordRepo();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
