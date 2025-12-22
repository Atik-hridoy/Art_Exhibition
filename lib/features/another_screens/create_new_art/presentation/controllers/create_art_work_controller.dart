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
    "price": priceCtrl.value.text, // Send as string, not number
    "description": descriptionCtrl
        .value
        .text, //   "An abstract oil painting capturing golden light bouncing off rippling surfaces.",
    "daimentions": {
      "height": heightCtrl.text, // Send as string
      "width": widthCtrl.text, // Send as string
    },
    "status": "Unique", // stable for Artist
    "authentication":
        authentications[selectedAuthIndex], // "Certificate of Authenticity",
    
    "acceptOffer": acceptOffers, // true,
  };

  Future<void> submit() async {
    if (imagePaths.isEmpty) {
      Utils.errorSnackBar('Error', 'Please upload at least one image');
      return;
    }

    if (categoryList == null || categoryList!.isEmpty) {
      Utils.errorSnackBar('Error', 'Please load categories first');
      return;
    }

    try {
      // Create body with proper types (not strings)
      Map<String, dynamic> bodyData = {
        "title": titleCtrl.value.text,
        "category": categoryList![selectedCategoryIndex].id,
        "price": priceCtrl.value.text, // Keep as string for API compatibility
        "description": descriptionCtrl.value.text,
        "daimentions.height": heightCtrl.text, // Send as individual fields
        "daimentions.width": widthCtrl.text, // Send as individual fields
        "status": "Unique",
        "authentication": authentications[selectedAuthIndex],
        
        "acceptOffer": acceptOffers, // Send as actual boolean
      };

      // Send all images as multipart with field name "images"
      var response = await ApiService.multipartMultipleWithJson(
        ApiEndPoint.featuresArt,
        header: {},
        body: bodyData,
        method: "POST",
        imageName: 'images',
        imagePaths: imagePaths,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        CreateExhibitionSuccessPopup.show();
      } else {
        Utils.errorSnackBar('Error', response.data['message'] ?? 'Failed to create artwork');
      }
    } catch (e) {
      Utils.errorSnackBar('Error', e.toString());
    }
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
