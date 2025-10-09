import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/constants/app_string.dart';

class ContinueWithGoogle extends StatelessWidget {
  const ContinueWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.normalGray2),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonImage(height: 25, width: 25, imageSrc: AppImages.google),

          CommonText(
            left: 15,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            text: AppString.signUpWithGoogle,
          ),
        ],
      ),
    );
  }
}
