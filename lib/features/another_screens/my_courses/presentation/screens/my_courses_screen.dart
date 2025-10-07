import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/bottom_nav_bar/common_bottom_bar.dart';
import 'package:tasaned_project/component/text/common_text.dart';
 import 'package:tasaned_project/features/another_screens/my_courses/presentation/widgets/my_courses_item.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        shadowColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        title: CommonText(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
          text: AppString.myCourses,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 23.sp,
            color: AppColors.titleColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            10.height,
         
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                itemCount: 6,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 190.h,
                ),
                itemBuilder: (context, index) {
                  return const MyCoursesItem();
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CommonBottomNavBar(currentIndex: 20),
    );
  }
}
