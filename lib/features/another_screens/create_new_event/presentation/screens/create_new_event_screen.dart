import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/component/text_field/common_text_field.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import '../controllers/create_new_event_controller.dart';

class CreateNewEventScreen extends StatelessWidget {
   CreateNewEventScreen({super.key});
  final String title = Get.arguments["title"];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewEventController>(
      init: CreateNewEventController(),
      builder: (c) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            shadowColor: AppColors.transparent,
            surfaceTintColor: AppColors.transparent,
            leading: InkWell(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, size: 22.sp, color: AppColors.titleColor),
            ),
            title:title=="Edit Event"? CommonText(
              text: AppString.editEvent,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
            ): CommonText(
              text: AppString.createNewEvent,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: AppString.basicInformation,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                        textAlign: TextAlign.left,
                      ),
                      10.height,
                      Row(
                        children: [
                          _stepBar(active: true),
                          6.width,
                          _stepBar(active: false),
                          6.width,
                          _stepBar(active: false),
                        ],
                      ),

                      20.height,
                      CommonText(
                        text: AppString.eventTitle,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                        textAlign: TextAlign.left,
                      ),
                      8.height,
                      CommonTextField(
                        hintText: AppString.enterExhibitionTitle,
                        controller: c.titleController,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                      ),

                      12.height,
                      CommonText(
                        text: AppString.description,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                        textAlign: TextAlign.left,
                      ),
                      8.height,
                      CommonTextField(
                        hintText: AppString.writeSomethingAboutTheExhibition,
                        controller: c.descriptionController,
                        maxline: 4,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                      ),

                      12.height,
                      CommonText(
                        text: AppString.overview,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                        textAlign: TextAlign.left,
                      ),
                      8.height,
                      CommonTextField(
                        hintText: AppString.writeSomethingAboutTheExhibition,
                        controller: c.overviewController,
                        maxline: 4,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                      ),

                      12.height,
                      CommonText(
                        text: AppString.eventDate,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                        textAlign: TextAlign.left,
                      ),
                      8.height,
                      CommonTextField(
                        hintText: AppString.mmDdYyyy,
                        controller: c.startDateController,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                        suffixIcon: InkWell(
                          onTap: () => c.pickStartDate(context),
                          child: Icon(Icons.calendar_month_outlined, color: AppColors.normalGray2),
                        ),
                      ),

                      12.height,
                      CommonText(
                        text: AppString.endDateLabel,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                        textAlign: TextAlign.left,
                      ),
                      8.height,
                      CommonTextField(
                        hintText: AppString.mmDdYyyy,
                        controller: c.endDateController,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                        suffixIcon: InkWell(
                          onTap: () => c.pickEndDate(context),
                          child: Icon(Icons.calendar_month_outlined, color: AppColors.normalGray2),
                        ),
                      ),

                      12.height,
                      CommonText(
                        text: AppString.visitingHours,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                        textAlign: TextAlign.left,
                      ),
                      8.height,
                      CommonTextField(
                        hintText: AppString.visitingHoursHint,
                        controller: c.visitingHoursController,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                      ),

                      12.height,
                      CommonText(
                        text: AppString.venueTitle,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                        textAlign: TextAlign.left,
                      ),
                      8.height,
                      CommonTextField(
                        hintText: AppString.egNewYork,
                        controller: c.venueController,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                      ),
                    ],
                  ),
                ),

                16.height,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                    border: Border(
                      top: BorderSide(color: AppColors.stroke),
                    ),
                  ),
                  child: Column(
                    children: [
                      20.height,
                      CommonButton(
                        buttonRadius: 60,
                        titleColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                        buttonColor: AppColors.white,
                        titleText: AppString.saveAsDraft,
                        onTap: () {
                          c.saveAsDraft();
                        },
                      ),
                      12.height,
                      CommonButton(
                        titleText: AppString.next,
                        buttonRadius: 60,
                        onTap: () {
                        // Save current step data before navigating
                        c.saveCurrentStepData();
                        Get.toNamed(AppRoutes.createNewEventGalleryScreen, arguments: {
                          "title":title=="Edit Event"? "Edit Event" : "Create New Event"
                        });
                        },
                      ),
                      20.height,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _stepBar({required bool active}) {
    return Expanded(
      child: Container(
        height: 6.h,
        decoration: BoxDecoration(
          color: active ? AppColors.primaryColor : AppColors.normalGray,
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
    );
  }
}
