import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

import '../../../../../component/button/common_button.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_images.dart';
import '../controller/sign_up_controller.dart';
import '../../../../../utils/constants/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../utils/constants/app_string.dart';

class VerifyUser extends StatefulWidget {
  const VerifyUser({super.key});

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SignUpController.instance.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Body Section starts here
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
          GetBuilder<SignUpController>(
            builder: (controller) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      /// instruction how to get OTP
                      35.height,
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.textFiledColor,
                        ),
                      ).start,

                      73.height,

                      Center(
                        child: CommonImage(
                          height: 120,
                          width: 120,
                          fill: BoxFit.cover,
                          imageSrc: AppImages.logo,
                        ).center,
                      ),

                      32.height,
                      CommonText(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,

                        text: AppString.otpVerify,
                      ),

                      CommonText(
                        fontSize: 12,
                        left: 12,
                        right: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.titleColor,
                        maxLines: 3,

                        text: AppString.otpVerifyDes,
                      ),

                      32.height,

                      /// OTP Filed here
                      Flexible(
                        flex: 0,
                        child: PinCodeTextField(
                          controller: controller.otpController,
                          validator: (value) {
                            if (value != null && value.length == 4) {
                              return null;
                            } else {
                              return AppString.otpIsInValid;
                            }
                          },
                          autoDisposeControllers: false,
                          cursorColor: AppColors.black,
                          appContext: (context),
                          autoFocus: true,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 56.h,
                            fieldWidth: 56.w,
                            activeFillColor: AppColors.transparent,
                            selectedFillColor: AppColors.transparent,
                            inactiveFillColor: AppColors.transparent,
                            borderWidth: 0.5.w,
                            selectedColor: AppColors.primaryColor,
                            activeColor: AppColors.primaryColor,
                            inactiveColor: AppColors.titleColorSecondary,
                          ),
                          length: 4,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.disabled,
                          enableActiveFill: true,
                        ),
                      ),

                      CommonText(top: 28, text: AppString.otpSent),
                      controller.time == '00:00'
                          ? InkWell(
                              onTap: () {
                                controller.startTimer();
                                // controller.forgotPasswordRepo();
                              },
                              child: CommonText(
                                top: 5,

                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                                text: AppString.resendCode,
                              ),
                            )
                          : CommonText(
                              fontSize: 12,
                              top: 8,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor,
                              text: controller.time,
                            ),

                      24.height,

                      ///  Submit Button here
                      CommonButton(
                        titleText: AppString.verify,
                        isLoading: controller.isLoadingVerify,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            Get.toNamed(AppRoutes.accountVerifiedScreen);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
