import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String imageSrc;
  const CategoryItem({super.key, required this.title, required this.imageSrc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
     // margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.stroke, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              child: CommonImage(
                height: double.infinity,
                width: double.infinity,
                fill: BoxFit.cover,
                imageSrc: imageSrc,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: CommonText(
              textAlign: TextAlign.center,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              maxLines: 1,
              text: title,
            ),
          ),
        ],
      ),
    );
  }
}
