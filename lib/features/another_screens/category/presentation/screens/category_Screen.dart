import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/category_item.dart';
import '../controller/category_controller.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 23.sp, color: AppColors.titleColor),
        ),
        title: CommonText(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
          text: AppString.allCategories,
        ),
      ),

      body: GetBuilder<CategoryController>(
        init: CategoryController(),
        builder: (c) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: GridView.builder(
            itemCount: c.categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 16.h,
              mainAxisExtent: 130.h,
            ),
            itemBuilder: (context, index) {
              final item = c.categories[index];
              return InkWell(
                onTap: () => Get.toNamed(
                  AppRoutes.featureArtsScreen,
                  arguments: {"title": AppString.featureArts},
                ),
                child: CategoryItem(title: item['title']!, imageSrc: item['image']!),
              );
            },
          ),
        ),
      ),

      // bottomNavigationBar: CommonBottomNavBar(currentIndex: 1),
    );
  }
}
