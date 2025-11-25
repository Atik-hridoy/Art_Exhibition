import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';

class ResaleArtController extends GetxController {
  ResaleArtController({required this.order});

  final Map<String, dynamic> order;

  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController infoCtrl = TextEditingController();

  final RxString condition = ''.obs; // Excellent, Very good, Good, Fair, Bad
  final RxBool acceptOffers = true.obs;

  final List<String> conditions = const [
    AppString.excellent,
    AppString.veryGood,
    AppString.good,
    AppString.fair,
    AppString.bad,
  ];

  void setCondition(String value) {
    condition.value = value;
    update();
  }

  void toggleAccept(bool value) {
    acceptOffers.value = value;
    update();
  }

  bool get isValid => priceCtrl.text.trim().isNotEmpty && condition.value.isNotEmpty;

  void submitListing() {
    if (!isValid) {
      Get.snackbar(AppString.tryAgain, '${AppString.enterAmount} & ${AppString.productCondition}');
      return;
    }

    Get.back();
    Get.snackbar(AppString.confirmation, '${AppString.addListing} ${AppString.done}');
  }

  @override
  void onClose() {
    priceCtrl.dispose();
    infoCtrl.dispose();
    super.onClose();
  }
}
