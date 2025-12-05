import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class OfferSubmittedScreen extends StatelessWidget {
  const OfferSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
          text: AppString.confirmation,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 23.sp,
            color: AppColors.titleColor,
          ),
        ),
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        91.height,
          CommonImage(
            height: 80,
            width: 80,
            imageSrc: AppImages.confirm,
          ).center,
          32.height,
          CommonText(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
            text: AppString.offerSubmittedSuccessfully,
            textAlign: TextAlign.center,
          ),
          12.height,
          CommonText(
            left: 24,
            right: 24,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.bodyClr,
            text: AppString.offerSubmittedDes,
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
          30.height,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CommonButton(
              buttonRadius: 60,
              titleText: AppString.backToHome,
              onTap: () => Get.offAllNamed(AppRoutes.userHomeScreen),
            ),
          ),
        ],
      ),
    );
  }
}
