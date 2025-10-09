import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

import '../../../../../component/button/common_button.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/constants/app_string.dart';

class ResetPassSuccessPopUp {
  static successPopUp() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonImage(height: 80, width: 80, imageSrc: AppImages.passwordChangeLogo),

              12.height,

              CommonText(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
                text: AppString.changedPassword,
              ),

              CommonText(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                maxLines: 2,
                color: AppColors.bodyClr,
                text: AppString.changedPasswordDes,
              ),

              24.height,

              CommonButton(
                onTap: () {
                  Get.toNamed(AppRoutes.signIn);
                },
                titleText: AppString.backToLogin,
              ),
            ],
          ),
        );
      },
    );
  }
}
