import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class MyCoursesItem extends StatelessWidget {
  const MyCoursesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(AppRoutes.myCoursesDetailsScreen);
      },
      child: Container(
        //margin: EdgeInsets.only(right: 16.w),
        width: 158.w,
        height: 170.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CommonImage(
                    width: 158.w,
                    fill: BoxFit.cover,
                    height: 112.h,
                    imageSrc: AppImages.learning,
                  ),
                ),

                Positioned(
                  top: 7,
                  right: 7,
                  child: Container(
                    padding: EdgeInsets.all(4),

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                    child: Icon(size: 16.sp, Icons.favorite_border),
                  ),
                ),
              ],
            ),

            5.height,


            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 6),
              child: CommonText(
                  left: 4,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.titleColor,
                  text: "6-Week Acrylic "),
            ),
            4.height,
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 6),
              child: CommonText(
                  left: 4,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.titleColor,
                  text: "Painting Workshop Kit"),
            ),
          ],
        ),
      ),
    );
  }
}
