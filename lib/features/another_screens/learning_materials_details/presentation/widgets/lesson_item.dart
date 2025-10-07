
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/features/another_screens/my_courses/presentation/screens/my_courses_details_screen.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class LessonItem extends StatelessWidget {
  const LessonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.stroke
        )
      ),
      
      child: Row(
        children: [
          
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CommonImage(
                height: 68,
                width: 68,
                fill: BoxFit.cover,
                imageSrc: AppImages.learning),
          ),
          
          13.width,
          
          Expanded(
            child: Column(children: [
              
              CommonText(
            
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.titleColor,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  text: "Introduction to Acrylics & Basic Techniques"),
              
              5.height,
              
              Row(
                children: [
                  Icon(
                    size: 15.sp,
                    Icons.watch_later_outlined,color: AppColors.bodyClr,),
                  
                  CommonText(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyClr,
                      left: 5,
                      text: "05:10")
                ],
              )
            ],),
          ),



SizedBox(
  
  height: 24.h,
  width: 24.h,
  child: _buildMoreMenu(context))
 ],
      ),
    );
  }



    Widget _buildMoreMenu(BuildContext context) {
        return PopupMenuButton<MyCoursesMenu>(
      icon: Icon(
        Icons.more_vert,
        size: 22.sp,
        color: AppColors.titleColor,
      ),
      color: AppColors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      itemBuilder: (context) => [
        PopupMenuItem<MyCoursesMenu>(
          value: MyCoursesMenu.edit,
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 20.sp, color: AppColors.titleColor),
              SizedBox(width: 8.w),
              CommonText(
                text: 'Edit',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.titleColor,
              ),
            ],
          ),
        ),
        const PopupMenuDivider(height: 8),
        PopupMenuItem<MyCoursesMenu>(
          value: MyCoursesMenu.delete,
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: 20.sp, color: Colors.red),
              SizedBox(width: 8.w),
              CommonText(
                text: 'Delete',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.red,
             ),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case MyCoursesMenu.edit:
            // TODO: Navigate to Edit screen or show edit flow
            break;          case MyCoursesMenu.delete:
            // TODO: Show delete confirmation dialog
            break;
        }
      },
    );
  }
 
}
