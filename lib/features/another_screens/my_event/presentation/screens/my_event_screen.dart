import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/my_event/presentation/controller/my_event_controller.dart';
import 'package:tasaned_project/features/another_screens/my_event/presentation/widgets/my_event_item.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class MyEventScreen extends StatelessWidget {
  const MyEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyEventController(),
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
              text: AppString.myEvents,
            ),
            leading: InkWell(
              onTap: () {
                Get.offAllNamed(AppRoutes.userHomeScreen);
              },
              child: Icon(Icons.arrow_back_ios, size: 23.sp, color: AppColors.titleColor),
            ),
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                15.height,

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GridView.builder(
                    itemCount: controller.eventList?.length ?? 0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                            AppRoutes.eventDetailsScreen,
                            arguments: {"title": "My Events"},
                          );
                        },
                        child: MyEventItem(
                          cover: controller.eventList?[index].cover ?? '',
                          title: controller.eventList?[index].title ?? '',
                          date: controller.eventList?[index].date ?? '',
                          month: controller.eventList?[index].month ?? '',
                          venue: controller.eventList?[index].venue ?? '',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
