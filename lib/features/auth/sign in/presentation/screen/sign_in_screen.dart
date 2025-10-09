import 'package:flutter/material.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/sign_in_controller.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_string.dart';
import '../../../../../utils/helpers/other_helper.dart';
import '../widgets/continue_with_google.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../../services/storage/storage_keys.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Body Sections Starts here
      body: GetBuilder<SignInController>(
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
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          80.height,

                          Center(
                            child: CommonImage(
                              height: 80,
                              width: 80,
                              fill: BoxFit.cover,
                              imageSrc: AppImages.logo,
                            ).center,
                          ),

                          /// Log In Instruction here
                          Center(
                            child: CommonText(
                              text: AppString.signIn,
                              fontSize: 24,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              top: 22,
                            ),
                          ),

                          Center(
                            child: CommonText(
                              text: AppString.signInDes,
                              fontSize: 12,
                              maxLines: 3,
                              bottom: 32,
                              left: 30,
                              right: 30,
                              top: 10,
                              color: AppColors.bodyClr,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          /// Account Email Input here
                          CommonText(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.titleColor,
                            text: AppString.email,
                            bottom: 8,
                          ),
                          CommonTextField(
                            controller: controller.emailController,

                            borderColor: AppColors.normalGray2,
                            hintText: AppString.enterYourEmail,
                            validator: OtherHelper.emailValidator,
                          ),

                          /// Account Password Input here
                          const CommonText(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            text: AppString.password,
                            bottom: 8,
                            top: 18,
                          ),
                          CommonTextField(
                            borderColor: AppColors.normalGray2,

                            controller: controller.passwordController,

                            isPassword: true,
                            hintText: AppString.enterYouPassword,
                            validator: OtherHelper.passwordValidator,
                          ),

                          12.height,

                          /// Forget Password Button here
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Checkbox toggle করার জন্য controller কে call করা
                                  controller.isRememberToggle();
                                },
                                child: Container(
                                  width: 24.h,
                                  height: 24.w,
                                  decoration: BoxDecoration(
                                    color: controller.isRemember
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                    border: Border.all(
                                      width: controller.isRemember ? 0 : 2,
                                      color: controller.isRemember
                                          ? AppColors.white
                                          : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: controller.isRemember
                                      ? Icon(Icons.check, color: Colors.white, size: 20)
                                      : null,
                                ),
                              ),

                              8.width,

                              CommonText(
                                fontSize: 14,
                                color: AppColors.titleColorSecondary,
                                fontWeight: FontWeight.w500,
                                text: AppString.rememberMe,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                                child: const CommonText(
                                  text: AppString.forgotThePassword,

                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          25.height,

                          /// Submit Button here

                          /// Submit Button here
                          // CommonButton(
                          //   buttonRadius: 60,
                          //   titleText: AppString.signIn,
                          //   isLoading: controller.isLoading,
                          //   onTap: (){
                          //     controller.signInUser();
                          //   },
                          // ),

                          // Quick Sign-in by Role (frontend only)
                          CommonButton(
                            titleText: "Sign in as ${AppString.roleVisitorTitle}",
                            buttonRadius: 60,
                            onTap: () async {
                              await LocalStorage.setString(
                                LocalStorageKeys.myRoll,
                                'visitor',
                              );
                              LocalStorage.myRoll = 'visitor';

                              Get.offAllNamed(AppRoutes.userHomeScreen);
                            },
                          ),
                          10.height,
                          CommonButton(
                            titleText: "Sign in as ${AppString.roleArtistTitle}",
                            buttonRadius: 60,
                            onTap: () async {
                              await LocalStorage.setString(
                                LocalStorageKeys.myRoll,
                                'artist',
                              );
                              LocalStorage.myRoll = 'artist';
                              Get.snackbar(
                                AppString.signIn,
                                'Signed in as ${AppString.roleArtistTitle}',
                              );
                              Get.offAllNamed(AppRoutes.userHomeScreen);
                            },
                          ),
                          10.height,
                          CommonButton(
                            titleText: "Sign in as ${AppString.roleCollectorTitle}",
                            buttonRadius: 60,
                            onTap: () async {
                              await LocalStorage.setString(
                                LocalStorageKeys.myRoll,
                                'collector',
                              );
                              LocalStorage.myRoll = 'collector';
                              Get.snackbar(
                                AppString.signIn,
                                'Signed in as ${AppString.roleCollectorTitle}',
                              );
                              Get.offAllNamed(AppRoutes.userHomeScreen);
                            },
                          ),
                          10.height,
                          CommonButton(
                            titleText: "Sign in as ${AppString.roleCuratorTitle}",
                            buttonRadius: 60,
                            onTap: () async {
                              await LocalStorage.setString(
                                LocalStorageKeys.myRoll,
                                'curator',
                              );
                              LocalStorage.myRoll = 'curator';
                              Get.snackbar(
                                AppString.signIn,
                                'Signed in as ${AppString.roleCuratorTitle}',
                              );
                              Get.offAllNamed(AppRoutes.userHomeScreen);
                            },
                          ),
                          10.height,
                          CommonButton(
                            titleText: "Sign in as ${AppString.roleMuseumTitle}",
                            buttonRadius: 60,
                            onTap: () async {
                              await LocalStorage.setString(
                                LocalStorageKeys.myRoll,
                                'museum',
                              );
                              LocalStorage.myRoll = 'museum';
                              Get.snackbar(
                                AppString.signIn,
                                'Signed in as ${AppString.roleMuseumTitle}',
                              );
                              Get.offAllNamed(AppRoutes.userHomeScreen);
                            },
                          ),
                          10.height,
                          CommonButton(
                            titleText:
                                "Sign in as ${AppString.roleEducationalInstitutionTitle}",
                            buttonRadius: 60,
                            onTap: () async {
                              await LocalStorage.setString(
                                LocalStorageKeys.myRoll,
                                'educational_institution',
                              );
                              LocalStorage.myRoll = 'educational_institution';
                              Get.snackbar(
                                AppString.signIn,
                                'Signed in as ${AppString.roleEducationalInstitutionTitle}',
                              );
                              Get.offAllNamed(AppRoutes.userHomeScreen);
                            },
                          ),

                          16.height,

                          // Or divider
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

                          16.height,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonText(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textFiledColor,
                                text: AppString.newHere,
                              ),

                              5.width,

                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.chooseRole);
                                },
                                child: CommonText(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                  text: AppString.joinUs,
                                ),
                              ),
                            ],
                          ),
                        ],
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
