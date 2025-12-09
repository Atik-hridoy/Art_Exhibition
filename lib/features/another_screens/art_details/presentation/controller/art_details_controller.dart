import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/feature_arts_model.dart';
import 'package:tasaned_project/features/data_model/features_art_card_model.dart';
import 'package:tasaned_project/features/profile/data/model/profile_model.dart';
import 'package:tasaned_project/features/profile/data/repository/profile_repository.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/services/storage/storage_services.dart';
import 'package:tasaned_project/services/storage/storage_keys.dart';
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
  final TextEditingController offerNameCtrl = TextEditingController();
  final TextEditingController offerPhoneCtrl = TextEditingController();
  final TextEditingController offerAddressCtrl = TextEditingController();
  
  // Profile data for offer dialog
  ProfileData? userProfile;
  bool hasProfileData = false;

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
      final artId = Get.arguments?['artId'] ?? '';
      if (artId.isEmpty) {
        Utils.errorSnackBar('Error', 'Art ID not provided');
        isArtDataLoading = false;
        update();
        return;
      }
      
      var response = await getArtDetails(artId: artId);
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

  Future<void> initialFunction() async {
    await artDetails();
    if (artData != null) {
      isFollowing = artData?.followArtist ?? false;
      isSaved = artData?.isOnFavorite ?? false;
      artID = artData?.id ?? '';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        update();
      });
    }
    await reletedArt();
  }

  Future<void> refreshArtDetails(String newArtId) async {
    artID = newArtId;
    await initialFunction();
  }

  /// Load user profile data for offer dialog
  Future<void> loadUserProfile() async {
    try {
      // First check local storage
      await _loadOfferFieldsFromStorage();
      
      // Then try to fetch from API
      final response = await ProfileRepository.getProfile();
      if (response != null && response.data != null) {
        userProfile = response.data;
        hasProfileData = true;
        
        // Populate offer fields from profile data
        if (userProfile!.shippingAddress != null) {
          offerNameCtrl.text = userProfile!.shippingAddress!.name;
          offerPhoneCtrl.text = userProfile!.shippingAddress!.phone;
          offerAddressCtrl.text = userProfile!.shippingAddress!.address;
          
          // Save to storage for offline use
          await saveOfferFieldsToStorage();
        }
      }
    } catch (e) {
      print("Error loading user profile: $e");
      hasProfileData = false;
    }
    update();
  }

  /// Load offer fields from local storage
  Future<void> _loadOfferFieldsFromStorage() async {
    try {
      offerNameCtrl.text = await LocalStorage.getString(LocalStorageKeys.offerName) ?? '';
      offerPhoneCtrl.text = await LocalStorage.getString(LocalStorageKeys.offerPhone) ?? '';
      offerAddressCtrl.text = await LocalStorage.getString(LocalStorageKeys.offerAddress) ?? '';
    } catch (e) {
      print("Error loading offer fields from storage: $e");
    }
  }

  /// Save offer fields to local storage
  Future<void> saveOfferFieldsToStorage() async {
    try {
      await LocalStorage.setString(LocalStorageKeys.offerName, offerNameCtrl.text);
      await LocalStorage.setString(LocalStorageKeys.offerPhone, offerPhoneCtrl.text);
      await LocalStorage.setString(LocalStorageKeys.offerAddress, offerAddressCtrl.text);
    } catch (e) {
      print("Error saving offer fields to storage: $e");
    }
  }

  /// Check if user has complete profile data
  bool get hasCompleteProfileData {
    return userProfile?.shippingAddress != null &&
           userProfile!.shippingAddress!.name.isNotEmpty &&
           userProfile!.shippingAddress!.phone.isNotEmpty &&
           userProfile!.shippingAddress!.address.isNotEmpty;
  }

  /// Create an offer
  Future<void> createOffer() async {
    try {
      // Construct the request body according to API structure
      final Map<String, dynamic> requestBody = {
        "art": artData?.id ?? '',
        "priceOffer": int.tryParse(offerAmountCtrl.text) ?? 0,
        "additionalNote": offerMessageCtrl.text,
        "shippingAddress": {
          "name": offerNameCtrl.text,
          "phone": offerPhoneCtrl.text,
          "address": offerAddressCtrl.text,
        },
      };

      print("Creating offer with data: $requestBody");

      var response = await ApiService.post(ApiEndPoint.offer, body: requestBody);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.successSnackBar('Success', 'Offer submitted successfully!');
        
        // Save offer fields to storage for future use
        await saveOfferFieldsToStorage();
        
        // Navigate to offer submitted screen
        Get.back();
        Get.toNamed(AppRoutes.offerSubmittedScreen);
      } else {
        Utils.errorSnackBar('Error', 'Failed to submit offer: ${response.message}');
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Something went wrong: $e');
      print("Error creating offer: $e");
    }
  }

  @override
  void onInit() {
    // Check if we have new artId from navigation arguments
    final newArtId = Get.arguments?['artId'] ?? '';
    if (newArtId.isNotEmpty && newArtId != artID) {
      artID = newArtId;
      initialFunction();
    } else {
      initialFunction();
    }
    
    // Load user profile for offer dialog
    loadUserProfile();
    
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    offerAmountCtrl.dispose();
    offerMessageCtrl.dispose();
    offerNameCtrl.dispose();
    offerPhoneCtrl.dispose();
    offerAddressCtrl.dispose();
    super.onClose();
  }
}
