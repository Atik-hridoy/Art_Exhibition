import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Lightweight controller for the UploadNewCourseScreen to keep
/// text-field state and media selections in one place.
class UploadNewCourseController extends GetxController {
  /// Form controllers
  final TextEditingController courseTitleCtrl = TextEditingController();
  final TextEditingController overviewCtrl = TextEditingController();
  final TextEditingController objectivesCtrl = TextEditingController();
  final TextEditingController lessonTitleCtrl = TextEditingController();
  final TextEditingController lessonDescriptionCtrl = TextEditingController();

  /// File placeholders
  String? thumbnailPath;
  String? lessonVideoPath;

  bool isPublishing = false;

  void pickThumbnail() {
    // TODO: connect with image picker when backend wiring is ready
    thumbnailPath = 'mock_thumbnail.png';
    update();
  }

  void pickLessonVideo() {
    // TODO: connect with video picker when backend wiring is ready
    lessonVideoPath = 'mock_video.mp4';
    update();
  }

  Future<void> saveDraft() async {
    // TODO: persist draft once API contract is finalized
    Get.snackbar('Draft saved', 'Course draft stored locally (mock).');
  }

  Future<void> publishCourse() async {
    isPublishing = true;
    update();
    await Future.delayed(const Duration(seconds: 1));
    isPublishing = false;
    update();
    Get.snackbar('Publish', 'This action is not wired yet.');
  }

  @override
  void onClose() {
    courseTitleCtrl.dispose();
    overviewCtrl.dispose();
    objectivesCtrl.dispose();
    lessonTitleCtrl.dispose();
    lessonDescriptionCtrl.dispose();
    super.onClose();
  }
}
