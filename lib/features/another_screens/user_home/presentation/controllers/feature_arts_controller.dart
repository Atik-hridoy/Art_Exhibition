import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/features_art_card_model.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class FeatureArtsController extends GetxController {
  // Sort options: 0 = Newest Arrivals, 1 = Popularity, 2 = Price
  bool featureArtIsLoading = false;
  List<FeaturesArtCardModel>? featureArtList;
  int selectedSort = 0;

  Future<void> featuredArt() async {
    try {
      featureArtIsLoading = true;
      var response = await getFeaturedArt();
      if (response != null) {
        featureArtList = response;
        featureArtIsLoading = false;
      }
      update();
    } catch (error) {
      featureArtIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  // Categories for demo
  final List<String> categories = const [
    'Choose Category',
    'Painting',
    'Sculpture',
    'Photography',
    'Digital Art',
  ];
  int selectedCategoryIndex = 0; // default: Choose Category

  // Price range (demo values)
  double minPrice = 0;
  double maxPrice = 5000;
  RangeValues priceRange = const RangeValues(1000, 4000);

  // Status: 'Unique' or 'Resale'
  String status = 'Unique';

  void setSort(int index) {
    selectedSort = index;
    update();
  }

  void setPrice(RangeValues values) {
    priceRange = values;
    update();
  }

  void setCategoryIndex(int index) {
    selectedCategoryIndex = index;
    update();
  }

  void setStatus(String value) {
    status = value;
    update();
  }

  void resetFilters() {
    selectedCategoryIndex = 0;
    priceRange = const RangeValues(1000, 4000);
    status = 'Unique';
    update();
  }

  @override
  void onInit() {
    featuredArt();
    super.onInit();
  }
}
