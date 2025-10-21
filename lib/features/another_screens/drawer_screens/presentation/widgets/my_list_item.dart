import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_images.dart';

class MyListItem extends StatelessWidget {
  // final String image;
  // final String artTitle;
  // final String price;
  // final bool isSold;

  const MyListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),

      child: Row(
        children: [
          CommonImage(height: 80, width: 100, borderRadius: 8, imageSrc: AppImages.arts),

          6.width,

          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.titleColor,
                      text: "Whispers of the Forest",
                    ),

                    Icon(color: AppColors.titleColor, Icons.more_vert),
                  ],
                ),

                6.height,

                Row(
                  children: [
                    ClipOval(
                      child: CommonImage(
                        height: 25,
                        width: 25,
                        fill: BoxFit.cover,
                        imageSrc: AppImages.female,
                      ),
                    ),

                    CommonText(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyClr,
                      left: 5,
                      text: "John Doe",
                    ),
                  ],
                ),

                6.height,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    CommonText(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                      left: 5,
                      text: "\$450",
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                      child: CommonText(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.green,
                        text: "Available",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
