import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/feature_arts_model.dart';
import 'package:tasaned_project/features/data_model/features_art_card_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';

class ArtDetailsController extends GetxController {
  final PageController pageController = PageController();
  int currentIndex = 0;
  bool isFollowing = false;
  bool isArtDataLoading = false;
  bool relatedArtIsLoading = false;
  bool isSaved = false;
  List<FeaturesArtCardModel>? relatedArtList;
  ArtDetails? artData;
  String? category;
  String? artID;

  // Make an Offer popup controllers
  final TextEditingController offerAmountCtrl = TextEditingController(text: '15');
  final TextEditingController offerMessageCtrl = TextEditingController();

  final List<String> images = [
    AppImages.arts,
    AppImages.exhibitionScreen,
    AppImages.learningBanner,
  ];

  void setIndex(int i) {
    currentIndex = i;
    update();
  }

  void toggleFollow({required String artistID}) async {
    try {
      Map<String, dynamic> body = {"followingId": artistID};
      var response = await ApiService.post(ApiEndPoint.following, body: body);
      if (response.statusCode == 200) {
        isFollowing = true;
        update();
      }
    } catch (e) {
      Utils.errorSnackBar('An error with following', 'Please contact with developer');
      update();
    }
  }

  void toggleUnfollow({required String artistID}) async {
    try {
      Map<String, dynamic> body = {"artistId": artistID};
      var response = await ApiService.post(ApiEndPoint.unFollowing, body: body);
      if (response.statusCode == 200) {
        isFollowing = false;
        update();
      }
    } catch (e) {
      Utils.errorSnackBar('An error with unfollowing', 'Please contact with developer');
      update();
    }
  }

  Future<void> saveToggle() async {
    try {
      Map<String, dynamic> body = {'type': 'Arts', "item": artID};
      var response = await ApiService.post(ApiEndPoint.saveToggle, body: body);
      if (response.statusCode == 200) {
        response.data["data"]["deletedCount"] == null ? isSaved = true : isSaved = false;
        update();
      }
    } catch (e) {
      Utils.errorSnackBar('An error with saving', 'Please contact with developer');
      update();
    }
  }

  Future<void> saveRelatedArtToggle({required int index}) async {
    try {
      FeaturesArtCardModel? art = relatedArtList?[index];
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

  Future<void> artDetails() async {
    try {
      isArtDataLoading = true;
      var response = await getArtDetails(
        // TODO: Need to change the Category parameter
        artId: '68e12c277824f46549f811ba',
      );
      if (response != null) {
        artData = response;
        category = artData?.category?.id ?? '';
        isArtDataLoading = false;
      }
      update();
    } catch (error) {
      isArtDataLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  Future<void> reletedArt() async {
    try {
      relatedArtIsLoading = true;
      var response = await getFeaturedArt(category: category ?? '', limit: 8, page: 1);
      if (response != null) {
        relatedArtList = response;
        var temp = relatedArtList!.where((art) => art.id != artID).toList();
        relatedArtList = temp;
        relatedArtIsLoading = false;
      }
      update();
    } catch (error) {
      relatedArtIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  void initialFunction() async {
    await artDetails();
    if (artData != null) {
      isFollowing = artData?.followArtist ?? false;
      isSaved = artData?.isOnFavorite ?? false;
      artID = artData?.id ?? '';
    }
    await reletedArt();
  }

  @override
  void onInit() {
    initialFunction();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    offerAmountCtrl.dispose();
    offerMessageCtrl.dispose();
    super.onClose();
  }
}
