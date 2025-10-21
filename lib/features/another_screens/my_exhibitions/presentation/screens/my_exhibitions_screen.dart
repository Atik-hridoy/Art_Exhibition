import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/my_exhibitions/presentation/controller/my_exhibitions_controller.dart';
import 'package:tasaned_project/features/another_screens/my_exhibitions/presentation/widgets/my_exhibitions_item.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';

class MyExhibitionsScreen extends StatelessWidget {
  const MyExhibitionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyExhibitionsController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.background,
            shadowColor: AppColors.transparent,
            surfaceTintColor: AppColors.transparent,
            title: CommonText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
              text: AppString.myExhibition,
            ),
            leading: InkWell(
              onTap: () {
                Get.offAllNamed(AppRoutes.userHomeScreen);
              },
              child: Icon(Icons.arrow_back_ios, size: 23.sp, color: AppColors.titleColor),
            ),
          ),

          body: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.exhibitionList?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 1, // Horizontal space between items
              mainAxisSpacing: 20,

              mainAxisExtent: 190.h,
              // Vertical space between items
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.exhibitionDetailsScreen,
                    arguments: {"title": "My Exhibition"},
                  );
                },
                child: MyExhibitionsItem(
                  image: controller.exhibitionList?[index].image ?? '',
                  title: controller.exhibitionList?[index].title ?? 'N/A',
                  venue: controller.exhibitionList?[index].venue ?? 'N/A',
                  startDate:
                      controller.exhibitionList?[index].startDate ?? DateTime.now(),
                  endDate: controller.exhibitionList?[index].startDate ?? DateTime.now(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
