import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import '../controllers/create_new_event_gallery_controller.dart';

class CreateNewEventGalleryScreen extends StatelessWidget {
   CreateNewEventGalleryScreen({super.key});
  final String title = Get.arguments["title"];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewEventGalleryController>(
      init: CreateNewEventGalleryController(),
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
          body: SizedBox(
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: AppString.gallery,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                      ),
                      8.height,
                      Row(
                        children: [
                          _stepBar(active: true),
                          6.width,
                          _stepBar(active: true),
                          6.width,
                          _stepBar(active: false),
                        ],
                      ),
            
                      50.height,
                      CommonText(
                        text: AppString.eventImageLabel,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                      ),
                      8.height,
                      _imageUploadArea(c),
            
                     
                    ],
                  ),
                ),
            
               Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
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
                          // Save current images before navigating
                          c.saveCurrentImages();
                          Get.toNamed(AppRoutes.createNewEventTicketBookingScreen, arguments: {
                            "title": title=="Edit Event"? "Edit Event" : "Create New Event"
                          });
                        },
                      ),


                      30.height,
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

  Widget _imageUploadArea(CreateNewEventGalleryController controller) {
    if (controller.imagePaths.isEmpty) {
      return InkWell(
        onTap: controller.pickImages,
        child: DottedBorder(
          options: RectDottedBorderOptions(
            color: AppColors.stroke,
            strokeWidth: 1,
            dashPattern: const [4, 3],
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image, size: 28.sp, color: AppColors.titleColor),
                8.height,
                CommonText(
                  text: AppString.tapToUploadImage,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
                4.height,
                CommonText(
                  text: 'Photos: ${controller.photosCount}/10 : ${AppString.chooseYourMainPhotoFirstShort}',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bodyClr,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final tiles = <Widget>[];
    for (int i = 0; i < controller.imagePaths.length; i++) {
      tiles.add(
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.file(
                File(controller.imagePaths[i]),
                height: 90.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: InkWell(
                onTap: () => controller.removeImageAt(i),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 16.sp),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final canAddMore = controller.photosCount < CreateNewEventGalleryController.maxPhotos;
    if (canAddMore) {
      tiles.add(
        InkWell(
          onTap: controller.pickImages,
          child: Container(
            height: 90.h,
            decoration: BoxDecoration(
              color: AppColors.searchBg,
              border: Border.all(color: AppColors.stroke),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: AppColors.bodyClr),
                  4.height,
                  CommonText(
                    text: AppString.upload,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.bodyClr,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      itemCount: tiles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
        mainAxisExtent: 90.h,
      ),
      itemBuilder: (_, i) => tiles[i],
    );
  }




}
