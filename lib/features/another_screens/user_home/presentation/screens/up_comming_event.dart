import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/event_item.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/controllers/event_controller.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class UpComingEventScreen extends StatelessWidget {
  const UpComingEventScreen({super.key});

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
          text: AppString.upcomingEvents,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 23.sp, color: AppColors.titleColor),
        ),
      ),

      body: SingleChildScrollView(
        child: GetBuilder(
          init: EventController(),
          builder: (controller) {
            return Column(
              children: [
                15.height,

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GridView.builder(
                    itemCount: controller.eventsList?.length ?? 0,
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
                      final event = controller.eventsList?[index];
                      print('Home view - Event ID: ${event?.id}');
                      print('Home view - Event Title: ${event?.title}');
                      print('Home view - Events List Length: ${controller.eventsList?.length}');
                      return InkWell(
                        onTap: () {
                          print('Navigating to details with ID: ${event?.id}');
                          Get.toNamed(
                            AppRoutes.eventDetailsScreen,
                            arguments: {
                              "title": "User Home",
                              "eventId": event?.id
                            },
                          );
                        },
                        child: EventItem(
                          cover: controller.eventsList?[index].cover ?? '',
                          title: controller.eventsList?[index].title ?? '',
                          date: controller.eventsList?[index].date ?? '',
                          month: controller.eventsList?[index].month ?? '',
                          venue: controller.eventsList?[index].venue ?? '',
                          isSaved: controller.eventsList?[index].isOnFavorite ?? false,
                          onTapSave: () async {
                            controller.savedEventsListToggle(index: index);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
