import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/component/text_field/common_text_field.dart';
import 'package:tasaned_project/features/another_screens/my_courses/presentation/controller/upload_new_lesson_controller.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class UploadNewLessonScreen extends StatelessWidget {
   UploadNewLessonScreen({super.key});
  final String title=Get.arguments["title"];

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
          text: title,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 23.sp, color: AppColors.titleColor),
        ),
      ),
      body: GetBuilder<UploadNewLessonController>(
        init: UploadNewLessonController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: 'Lesson Title',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                    bottom: 10,
                  ),
                  CommonTextField(
                    controller: controller.titleCtrl,
                    hintText: 'Enter lesson title',
                    borderColor: AppColors.stroke,
                    fillColor: AppColors.white,
                  ),

                  16.height,
                  CommonText(
                    text: 'Lesson Description',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                    bottom: 10,
                  ),
                  CommonTextField(
                    controller: controller.descriptionCtrl,
                    hintText: 'Enter lesson Description',
                    maxline: 4,
                    borderColor: AppColors.stroke,
                    fillColor: AppColors.white,
                  ),

                  18.height,
                  CommonText(
                    text: 'Upload Lession Video',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                    bottom: 10,
                  ),
                  _UploadBox(
                    title: 'Upload Lession Video',
                    subtitle: 'Video up to 500MB',
                    icon: Icons.video_library_outlined,
                    onTap: controller.pickVideo,
                  ),
                  if (controller.videoPath != null) ...[
                    6.height,
                    CommonText(
                      text: controller.videoPath!.split('/').last,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyClr,
                    ),
                  ],

                  18.height,
                  CommonText(
                    text: 'Lesson Thumbnail',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                    bottom: 10,
                  ),
                  _UploadBox(
                    title: 'Upload Course Image',
                    subtitle: 'JPG, PNG up to 5MB',
                    icon: Icons.image_outlined,
                    onTap: controller.pickImage,
                  ),
                  if (controller.imagePath != null) ...[
                    6.height,
                    CommonText(
                      text: controller.imagePath!.split('/').last,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyClr,
                    ),
                  ],

                  24.height,
                  _OutlinedActionButton(
                    text: title=="Edit Lesson"?"Cancel":"Save as draft",
                    onTap: () {
                      // TODO: draft flow
                    },
                  ),

                  12.height,
                  _FilledActionButton(
                    text: 'Publish',
                    onTap: () {
                      // TODO: publish flow
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _UploadBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const _UploadBox({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28.sp, color: AppColors.titleColor),
            8.height,
            CommonText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              bottom: 4,
            ),
            CommonText(
              text: subtitle,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.bodyClr,
            ),
          ],
        ),
      ),
    );
  }
}

class _OutlinedActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _OutlinedActionButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side:  BorderSide(color:text=="Cancel"?AppColors.red: AppColors.primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          backgroundColor: AppColors.white,
        ),
        onPressed: onTap,
        child: CommonText(
          text: text,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color:text=="Cancel"?AppColors.red: AppColors.primaryColor,
        ),
      ),
    );
  }
}

class _FilledActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _FilledActionButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
        onPressed: onTap,
        child: CommonText(
          text: text,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    );
  }
}