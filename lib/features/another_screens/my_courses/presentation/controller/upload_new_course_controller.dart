import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:tasaned_project/utils/helpers/other_helper.dart';
import 'package:tasaned_project/services/storage/storage_keys.dart';
import 'package:tasaned_project/services/storage/storage_services.dart';

/// Lightweight controller for the UploadNewCourseScreen to keep
/// text-field state and media selections in one place.
class UploadNewCourseController extends GetxController {
  /// Form controllers
  final TextEditingController courseTitleCtrl = TextEditingController();
  final TextEditingController overviewCtrl = TextEditingController();
  final TextEditingController objectivesCtrl = TextEditingController();

  /// File placeholders
  String? thumbnailPath;

  bool isPublishing = false;

  @override
  void onInit() {
    super.onInit();
    _loadDraft();
  }

  Future<void> pickThumbnail() async {
    final path = await OtherHelper.openGallery();
    if (path != null && path.isNotEmpty) {
      thumbnailPath = path;
      update();
    }
  }

  Future<void> saveDraft() async {
    final payload = {
      'title': courseTitleCtrl.text,
      'overview': overviewCtrl.text,
      'objectives': objectivesCtrl.text,
      'thumbnailPath': thumbnailPath,
      'savedAt': DateTime.now().toIso8601String(),
    };

    try {
      await LocalStorage.setString(
        LocalStorageKeys.uploadCourseDraft,
        jsonEncode(payload),
      );
      Utils.successSnackBar('Draft saved', 'Course draft stored locally.');
    } catch (e) {
      Utils.errorSnackBar('Save failed', e.toString());
    }
  }

  Future<void> publishCourse() async {
    final title = courseTitleCtrl.text.trim();
    final overview = overviewCtrl.text.trim();
    final objectives = objectivesCtrl.text.trim();

    if (title.isEmpty || overview.isEmpty || objectives.isEmpty) {
      Utils.errorSnackBar('Missing info', 'All fields are required.');
      return;
    }

    if (thumbnailPath == null || thumbnailPath!.isEmpty) {
      Utils.errorSnackBar('Thumbnail required', 'Please upload a course thumbnail.');
      return;
    }

    try {
      isPublishing = true;
      update();

      final response = await addCourse(
        title: title,
        overview: overview,
        learningObject: objectives,
        thumbnailPath: thumbnailPath!,
      );

      if (response == null) {
        return;
      }

      if (response.statusCode == 200) {
        final payload = response.data['data'] ?? response.data;
        String? courseId;
        if (payload is Map) {
          courseId = (payload['_id'] ?? payload['id'] ?? payload['courseId'])?.toString();
        }

        Utils.successSnackBar('Success', 'Course saved successfully.');
        await _resetForm();
        Get.toNamed(
          AppRoutes.uploadNewLessonScreen,
          arguments: {
            'title': 'Upload Lesson',
            if (courseId != null) 'courseId': courseId,
          },
        );
      } else {
        Utils.errorSnackBar('Failed', response.message);
      }
    } finally {
      isPublishing = false;
      update();
    }
  }

  Future<void> _resetForm() async {
    courseTitleCtrl.clear();
    overviewCtrl.clear();
    objectivesCtrl.clear();
    thumbnailPath = null;
    await LocalStorage.remove(LocalStorageKeys.uploadCourseDraft);
    update();
  }

  Future<void> _loadDraft() async {
    try {
      final saved = await LocalStorage.getString(LocalStorageKeys.uploadCourseDraft);
      if (saved == null || saved.isEmpty) return;

      final decoded = jsonDecode(saved);
      if (decoded is! Map) return;

      courseTitleCtrl.text = decoded['title']?.toString() ?? '';
      overviewCtrl.text = decoded['overview']?.toString() ?? '';
      objectivesCtrl.text = decoded['objectives']?.toString() ?? '';
      final savedThumb = decoded['thumbnailPath']?.toString();
      if (savedThumb != null && savedThumb.isNotEmpty) {
        thumbnailPath = savedThumb;
      }
      update();
    } catch (e) {
      log('Failed to load course draft: $e');
    }
  }

  @override
  void onClose() {
    courseTitleCtrl.dispose();
    overviewCtrl.dispose();
    objectivesCtrl.dispose();
    super.onClose();
  }
}
