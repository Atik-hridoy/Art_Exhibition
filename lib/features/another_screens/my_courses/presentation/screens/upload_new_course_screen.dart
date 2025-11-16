import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/component/text_field/common_text_field.dart';
import 'package:tasaned_project/features/another_screens/my_courses/presentation/controller/upload_new_course_controller.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

/// Upload New Course screen backed by a lightweight controller.
class UploadNewCourseScreen extends StatelessWidget {
  UploadNewCourseScreen({super.key});

  final UploadNewCourseController controller =
      Get.put(UploadNewCourseController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UploadNewCourseController>(
      init: controller,
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            shadowColor: AppColors.transparent,
            surfaceTintColor: AppColors.transparent,
            title: CommonText(
              text: 'Upload New Course',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
            ),
            centerTitle: true,
            leading: InkWell(
              onTap: Get.back,
              child: Icon(Icons.arrow_back_ios, size: 22.sp, color: AppColors.titleColor),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CourseTextField(
                  label: 'Course Title',
                  hint: 'e.g Introduction of Arts',
                  controller: ctrl.courseTitleCtrl,
                ),
                _CourseTextField(
                  label: 'Course Overview',
                  hint: "Help students understand what they'll learn and why it matters",
                  controller: ctrl.overviewCtrl,
                  maxLines: 3,
                ),
                _CourseTextField(
                  label: 'Learning Objectives',
                  hint: 'List key skills or outcomes students will gain',
                  controller: ctrl.objectivesCtrl,
                  maxLines: 3,
                ),
                20.height,
                _UploadSlot(
                  title: 'Course Thumbnail',
                  actionLabel: 'Upload Course Image',
                  helperText: 'JPG, PNG up to 5MB',
                  icon: Icons.image_outlined,
                  onTap: ctrl.pickThumbnail,
                  fileName: ctrl.thumbnailPath,
                ),
                18.height,
                _UploadSlot(
                  title: 'Upload Lesson Video',
                  actionLabel: 'Upload Lesson Video',
                  helperText: 'Video up to 500MB',
                  icon: Icons.video_library_outlined,
                  onTap: ctrl.pickLessonVideo,
                  fileName: ctrl.lessonVideoPath,
                ),
                18.height,
                _CourseTextField(
                  label: 'Lesson Title',
                  hint: 'Enter lesson title',
                  controller: ctrl.lessonTitleCtrl,
                ),
                _CourseTextField(
                  label: 'Lesson Description',
                  hint: 'Enter lesson Description',
                  controller: ctrl.lessonDescriptionCtrl,
                  maxLines: 3,
                ),
                24.height,
                _PublishActions(
                  onDraft: ctrl.saveDraft,
                  onPublish: ctrl.isPublishing ? null : ctrl.publishCourse,
                  isPublishing: ctrl.isPublishing,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CourseTextField extends StatelessWidget {
  const _CourseTextField({
    required this.label,
    required this.hint,
    this.controller,
    this.maxLines = 1,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: label,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.titleColor,
            bottom: 10,
          ),
          CommonTextField(
            controller: controller,
            hintText: hint,
            maxline: maxLines,
            borderRadius: 12,
            fillColor: AppColors.white,
            borderColor: AppColors.stroke,
          ),
        ],
      ),
    );
  }
}

class _UploadSlot extends StatelessWidget {
  const _UploadSlot({
    required this.title,
    required this.actionLabel,
    required this.helperText,
    required this.icon,
    required this.onTap,
    this.fileName,
  });

  final String title;
  final String actionLabel;
  final String helperText;
  final IconData icon;
  final VoidCallback onTap;
  final String? fileName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
          bottom: 12,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 28.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.stroke, style: BorderStyle.solid),
              color: AppColors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 32.sp, color: AppColors.titleColor),
                8.height,
                CommonText(
                  text: actionLabel,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
                4.height,
                CommonText(
                  text: helperText,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bodyClr,
                ),
              ],
            ),
          ),
        ),
        if (fileName != null) ...[
          8.height,
          CommonText(
            text: fileName!,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.bodyClr,
          ),
        ],
      ],
    );
  }
}

class _PublishActions extends StatelessWidget {
  const _PublishActions({
    required this.onDraft,
    required this.onPublish,
    required this.isPublishing,
  });

  final VoidCallback onDraft;
  final VoidCallback? onPublish;
  final bool isPublishing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton(
          onPressed: onDraft,
          style: OutlinedButton.styleFrom(
            minimumSize: Size.fromHeight(52.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
            side: BorderSide(color: AppColors.primaryColor),
          ),
          child: CommonText(
            text: 'Save as draft',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        12.height,
        ElevatedButton(
          onPressed: onPublish,
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(52.h),
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
          ),
          child: isPublishing
              ? SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : CommonText(
                  text: 'Publish',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
        ),
      ],
    );
  }
}
