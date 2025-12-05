
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

class PaymentConfirmationScreen extends StatelessWidget {
  const PaymentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
            fontSize: 16,fontWeight: FontWeight.w600,
            text: AppString.confirmation),
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(
            color: AppColors.titleColor,
            Icons.arrow_back_ios, size: 23.sp,),
        ),
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          80.height,

          CommonImage(
            height: 80,
            width: 80,
            imageSrc: AppImages.confirm).center,

          22.height,
          CommonText(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              text: AppString.congratulations),

          12.height,
          CommonText(
              left: 24,
              right: 24,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.bodyClr,
              maxLines: 3,
              text: AppString.confirmationDes),

          24.height,

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CommonButton(
                buttonRadius: 60,
                titleText: AppString.purchaseHistoryTitle,
                onTap: () {
                  Get.toNamed(AppRoutes.purchaseHistory);
                }),
          ),

          16.height,

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CommonButton(
                buttonRadius: 60,
                onTap: () {
                  Get.toNamed(AppRoutes.userHomeScreen);
                },
                buttonColor: AppColors.transparent,
                borderColor: AppColors.primaryColor,
                titleColor: AppColors.primaryColor,
                titleWeight: FontWeight.w700,
                titleSize: 18,
                titleText: AppString.home),
          ),
        ],
      ),
    );
  }
}
