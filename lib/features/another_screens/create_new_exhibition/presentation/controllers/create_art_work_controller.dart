import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/category_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:tasaned_project/utils/helpers/other_helper.dart';
import 'package:tasaned_project/component/pop_up/create_exhibition_success_popup.dart';

class CreateArtWorkController extends GetxController {
  // Text controllers
  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final widthCtrl = TextEditingController();
  final heightCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  final List<String> imagePaths = []; // Images
  List<CategoryModel>? categoryList;
  bool categoryIsLoading = false;

  Future<void> category() async {
    try {
      categoryIsLoading = true;
      var response = await getCategory();
      if (response != null) {
        categoryList = response;
        categoryIsLoading = false;
      }
      update();
    } catch (error) {
      categoryIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

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

  Map<String, dynamic> get artWorkBody => {
    "title": titleCtrl.value.text, // "Echoes of Light",
    "category": categoryList![selectedCategoryIndex].id, //"68c6aeefb9190bc121d417b5",
    "price": num.tryParse(priceCtrl.value.text), // 6000,
    "description": descriptionCtrl
        .value
        .text, //   "An abstract oil painting capturing golden light bouncing off rippling surfaces.",
    "daimentions": {
      "height": num.tryParse(heightCtrl.text),
      "width": num.tryParse(widthCtrl.text),
    },
    "status": "Unique", // stable for Artist
    "authentication":
        authentications[selectedAuthIndex], // "Certificate of Authenticity",
    "resale": false,
    "acceptOffer": acceptOffers, // true,
  };

  void submit() {
    ApiService.post(ApiEndPoint.featuresArt, body: artWorkBody);
    CreateExhibitionSuccessPopup.show();
  }

  @override
  void onInit() {
    category();
    super.onInit();
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
