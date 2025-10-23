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

import '../controllers/create_new_exhibition_controller.dart';

class CreateNewExhibitionScreen extends StatelessWidget {
  CreateNewExhibitionScreen({super.key});

  final String title = Get.arguments["title"];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewExhibitionController>(
      init: CreateNewExhibitionController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            shadowColor: AppColors.transparent,
            surfaceTintColor: AppColors.transparent,
            title: CommonText(
              text: title == "Edit Exhibition"
                  ? AppString.editExhibition
                  : AppString.createExhibition,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
            ),
            leading: InkWell(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, size: 22.sp, color: AppColors.titleColor),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Step indicator (Basic Information active)
                      CommonText(
                        text: 'Basic Information',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                      ),
                      12.height,
                      Row(
                        children: [
                          _stepBar(active: true),
                          6.width,
                          _stepBar(active: false),
                          6.width,
                          _stepBar(active: false),
                          6.width,
                          _stepBar(active: false),
                        ],
                      ),

                      16.height,
                      _label(AppString.exhibitionTitle),
                      8.height,
                      CommonTextField(
                        hintText: AppString.enterExhibitionTitle,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                        controller: controller.titleCtrl,
                      ),

                      15.height,
                      _label(AppString.description),
                      8.height,
                      CommonTextField(
                        hintText: AppString.writeSomethingAboutTheExhibition,
                        maxline: 4,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                        controller: controller.descriptionCtrl,
                      ),

                      12.height,
                      _label(AppString.startDate),
                      8.height,
                      CommonTextField(
                        hintText: AppString.mmDdYyyy,
                        controller: controller.startDateCtrl,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                        onTap: controller.pickStartDate,
                        textInputAction: TextInputAction.next,
                        suffixIcon: Icon(
                          Icons.calendar_today_rounded,
                          color: AppColors.bodyClr,
                          size: 18.sp,
                        ),
                      ),

                      12.height,
                      _label(AppString.endDate),
                      8.height,
                      CommonTextField(
                        hintText: AppString.mmDdYyyy,
                        controller: controller.endDateCtrl,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                        onTap: controller.pickEndDate,
                        textInputAction: TextInputAction.next,
                        suffixIcon: Icon(
                          Icons.calendar_today_rounded,
                          color: AppColors.bodyClr,
                          size: 18.sp,
                        ),
                      ),

                      12.height,
                      _label(AppString.visitingHours),
                      8.height,
                      CommonTextField(
                        hintText: AppString.visitingHoursHint,
                        controller: controller.visitingHoursCtrl,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                      ),

                      12.height,
                      _label(AppString.venue),
                      8.height,
                      CommonTextField(
                        hintText: AppString.egNewYork,
                        controller: controller.venueCtrl,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                      ),

                      12.height,
                      _label(AppString.gallery),
                      8.height,
                      CommonTextField(
                        hintText: AppString.searchGallery,
                        controller: controller.galleryCtrl,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                        suffixIcon: Icon(Icons.search, color: AppColors.bodyClr),
                      ),
                    ],
                  ),
                ),

                24.height,
                // Bottom Buttons
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                    border: Border(top: BorderSide(color: AppColors.stroke)),
                  ),
                  child: Column(
                    children: [
                      24.height,
                      CommonButton(
                        buttonRadius: 60,
                        titleColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                        buttonColor: AppColors.white,
                        titleText: AppString.saveAsDraft,
                      ),
                      12.height,
                      CommonButton(
                        titleText: 'Next',
                        buttonRadius: 60,
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.createNewExhibitionGalleryScreen,
                            arguments: {
                              "title": title == "Edit Exhibition"
                                  ? "Edit Exhibition"
                                  : "Create New Exhibition",
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                30.height,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _label(String text) {
    return CommonText(
      text: text,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.titleColor,
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
