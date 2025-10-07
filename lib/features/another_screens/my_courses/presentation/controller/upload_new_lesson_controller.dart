import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/utils/helpers/other_helper.dart';

class UploadNewLessonController extends GetxController {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  String? videoPath;
  String? imagePath;

  Future<void> pickVideo() async {
    final path = await OtherHelper.pickVideoFromGallery();
    if (path != null && path.isNotEmpty) {
      videoPath = path;
      update();
    }
  }

  Future<void> pickImage() async {
    final path = await OtherHelper.openGallery();
    if (path != null && path.isNotEmpty) {
      imagePath = path;
      update();
    }
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descriptionCtrl.dispose();
    super.onClose();
  }
}
