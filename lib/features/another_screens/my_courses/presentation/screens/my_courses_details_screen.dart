import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/my_courses/presentation/controller/my_courses_details_controller.dart';
import 'package:tasaned_project/features/another_screens/my_courses/presentation/widgets/my_courses_heading_section.dart';
import 'package:tasaned_project/features/another_screens/my_courses/presentation/widgets/my_courses_lesions_section.dart';
import 'package:tasaned_project/features/another_screens/my_courses/presentation/widgets/my_courses_overview_section.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
enum MyCoursesMenu { edit, delete }


class MyCoursesDetailsScreen extends StatelessWidget {
  const MyCoursesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF9FFFFFF),
      appBar: AppBar(
        actions: [
        _buildMoreMenu(context),
          20.width
        ],
        leading: InkWell(

            onTap:(){
              Get.back();
            },

            child: Icon(Icons.arrow_back_ios, size: 23.sp, color: AppColors.titleColor,)),
        backgroundColor: AppColors.white,
        shadowColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: CommonText(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.titleColor,
            text: AppString.myCourses),
      ),

      body: SingleChildScrollView(
        child: GetBuilder(
          init: MyCoursesDetailsController(),
          builder: (controller) {
            return Column(
              children: [

                MyCoursesHeadingSection(),

                24.height,

                controller.isType=="overview"?MyCoursesOverviewSection():MyCoursesLesionsSection()


              ],
            );
          }
        ),
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
            Get.toNamed(AppRoutes.uploadNewLessonScreen, arguments: {
              "title":"Edit Lesson"
            });
            break;          case MyCoursesMenu.delete:
            // TODO: Show delete confirmation dialog
            break;
        }
      },
    );
  }
 }


