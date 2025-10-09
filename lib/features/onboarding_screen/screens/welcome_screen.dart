import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top background image section
            40.height,
            SizedBox(
              height: 530.h,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background image
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.welcomeScreenBgImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Bottom gradient fade
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 140.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.white.withOpacity(0.0), AppColors.white],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            12.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonText(
                    text: AppString.welcomeToTasaneeArt,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                    textAlign: TextAlign.center,
                  ),
                  8.height,
                  CommonText(
                    text: AppString.welcomeToTasaneeArtDes,
                    fontSize: 12,
                    color: AppColors.bodyClr,
                    fontWeight: FontWeight.w400,
                    maxLines: 3,
                  ),
                  20.height,
                  CommonButton(
                    titleText: AppString.getStarted,
                    buttonRadius: 50,
                    onTap: () => Get.offAllNamed(AppRoutes.onboarding),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
