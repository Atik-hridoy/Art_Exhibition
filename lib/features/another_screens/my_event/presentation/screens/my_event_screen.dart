import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/my_event/presentation/controller/my_event_controller.dart';
import 'package:tasaned_project/features/another_screens/my_event/presentation/widgets/my_event_item.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class MyEventScreen extends StatelessWidget {
  const MyEventScreen({super.key});

  // Helper function to format date
  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd').format(date);
  }

  // Helper function to format month
  String formatMonth(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMM').format(date);
  }

  // Helper function to get first image from images list
  String getFirstImage(List<String>? images) {
    if (images == null || images.isEmpty) return '';
    return images.first;
  }

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

          body: controller.myEventIsLoading
              ? Center(child: CircularProgressIndicator())
              : controller.eventList == null || controller.eventList!.isEmpty
                  ? Center(
                      child: CommonText(
                        text: 'No events found',
                        fontSize: 16,
                        color: AppColors.titleColor,
                      ),
                    )
                  : SingleChildScrollView(
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

                                mainAxisExtent: 195.h, // Increased from 190.h to fix overflow
                                // Vertical space between items
                              ),
                              itemBuilder: (context, index) {
                                final event = controller.eventList![index];
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes.eventDetailsScreen,
                                      arguments: {
                                        "eventId": event.id,
                                        "title": "My Events"
                                      },
                                    );
                                  },
                                  child: MyEventItem(
                                    cover: getFirstImage(event.images),
                                    title: event.title ?? '',
                                    date: formatDate(event.startDate),
                                    month: formatMonth(event.startDate),
                                    venue: event.venue ?? '',
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
