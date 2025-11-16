import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/learning_material_model.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class LearningMaterialDetailsController extends GetxController {
  String isType = "overview";
  bool isLoading = false;
  LearningMaterialModel? learningDetail;
  late final String learningId;

  @override
  void onInit() {
    super.onInit();
    learningId = Get.arguments?['learningId']?.toString() ?? '';
    if (learningId.isEmpty) {
      Utils.errorSnackBar('Invalid lesson', 'No learning id provided');
    } else {
      fetchLearningDetail();
    }
  }

  Future<void> fetchLearningDetail() async {
    if (learningId.isEmpty) return;
    try {
      isLoading = true;
      update();
      debugPrint('Fetching learning detail for id => $learningId');
      final response = await getLearningDetail(learningId);
      if (response != null) {
        debugPrint('Learning detail response title => ${response.title}');
        learningDetail = response;
      } else {
        Utils.errorSnackBar('Not found', 'Learning material not found');
      }
    } catch (e, s) {
      log('Learning detail error: $e');
      debugPrintStack(label: e.toString(), stackTrace: s);
      Utils.errorSnackBar('Error', 'Could not load learning material');
    } finally {
      isLoading = false;
      update();
    }
  }

  void updateType({String? type}) {
    if (type == null || type.isEmpty) return;
    isType = type;
    update();
  }
}