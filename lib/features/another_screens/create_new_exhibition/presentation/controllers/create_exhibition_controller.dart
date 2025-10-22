import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/utils/helpers/other_helper.dart';
import 'package:tasaned_project/component/pop_up/create_exhibition_success_popup.dart';

class CreateExhibitionController extends GetxController {
  // Text controllers
  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final widthCtrl = TextEditingController();
  final heightCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  // Dropdown selections
  final List<String> categories = [
    'Abstract Art',
    'Minimalist Art',
    'Pop Art',
    'Surrealism',
    'Contemporary Art',
    'Other',
  ];
  int selectedCategoryIndex = 0;

  final List<String> authentications = [
    'Hand Sign by Artist',
    'Certificate of Authenticity',
    'Gallery Verified',
    'None',
  ];
  int selectedAuthIndex = 0;

  // Toggles
  bool acceptOffers = true;

  // Images
  final List<String> imagePaths = [];

  int get photosCount => imagePaths.length;

  void setCategoryIndex(int i) {
    selectedCategoryIndex = i;
    update();
  }

  void setAuthIndex(int i) {
    selectedAuthIndex = i;
    update();
  }

  void toggleOffers(bool v) {
    acceptOffers = v;
    update();
  }

  Future<void> tapUpload() async {
    final remaining = 5 - imagePaths.length;
    if (remaining <= 0) return;
    final picked = await OtherHelper.pickMultipleImage(imageLimit: remaining);
    if (picked.isNotEmpty) {
      imagePaths.addAll(picked);
      update();
    }
  }

  void removeImageAt(int index) {
    if (index >= 0 && index < imagePaths.length) {
      imagePaths.removeAt(index);
      update();
    }
  }

  void submit() {
    CreateExhibitionSuccessPopup.show();
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descriptionCtrl.dispose();
    widthCtrl.dispose();
    heightCtrl.dispose();
    priceCtrl.dispose();
    super.onClose();
  }
}
