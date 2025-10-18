import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/feature_arts_model.dart';
import 'package:tasaned_project/features/data_model/features_art_card_model.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';

class ArtDetailsController extends GetxController {
  final PageController pageController = PageController();
  int currentIndex = 0;
  bool isFollowing = false;
  bool isArtDataLoading = false;
  bool relatedArtIsLoading = false;
  List<FeaturesArtCardModel>? relatedArtList;
  ArtDetails? artData;

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

  void toggleFollow() {
    isFollowing = !isFollowing;
    update();
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
      var response = await getFeaturedArt(
        // TODO: Need to change the Art ID parameter
        category: "68c6acff12675c04e6e0c568",
        limit: 8,
        page: 1,
      );
      if (response != null) {
        relatedArtList = response;
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
