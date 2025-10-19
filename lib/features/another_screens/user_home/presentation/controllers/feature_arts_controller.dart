import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/features_art_card_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
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

  Future<void> savedToggle({required int index}) async {
    try {
      FeaturesArtCardModel? art = featureArtList?[index];
      if (art == null) return;

      // // Optional: optimistic UI update (instant toggle before API)
      // art.isOnFavorite = !(art.isOnFavorite ?? false);
      // update();

      Map<String, dynamic> body = {'type': 'Arts', 'item': art.id};
      var response = await ApiService.post(ApiEndPoint.saveToggle, body: body);

      if (response.statusCode == 200) {
        // Sync based on backend response
        bool isNowSaved = response.data["data"]["deletedCount"] == null;
        art.isOnFavorite = isNowSaved;
        update();
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Could not toggle favorite');
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
