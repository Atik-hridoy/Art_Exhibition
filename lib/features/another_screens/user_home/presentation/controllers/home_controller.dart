import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/artist_card_model.dart';
import 'package:tasaned_project/features/data_model/category_model.dart';
import 'package:tasaned_project/features/data_model/event_card_model.dart';
import 'package:tasaned_project/features/data_model/exibition_card_model.dart';
import 'package:tasaned_project/features/data_model/features_art_card_model.dart';
import 'package:tasaned_project/features/data_model/learning_material_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class HomeController extends GetxController {
  List<FeaturesArtCardModel>? featureArtList;
  List<ArtistCardModel>? popularArtistList;
  List<FeaturesArtCardModel>? recommendedArtList;
  List<CategoryModel>? categoryList;
  List<ExhibitionCardModel>? exhibitionList;
  List<EventCardModel>? eventsList;
  List<LearningMaterialModel>? learningMaterials;
  bool featureArtIsLoading = false;
  bool categoryIsLoading = false;
  bool populartArtistIsLoading = false;
  bool recommendedArtIsLoading = false;
  bool upComingExibitionIsLoading = false;
  bool upComingEventIsLoading = false;
  bool learningMaterialIsLoading = false;

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

  void savedLearningListToggle({required int index}) async {
    try {
      LearningMaterialModel? learning = learningMaterials?[index];
      if (learning == null) return;

      Map<String, dynamic> body = {'type': 'Learning', 'item': learning.id};
      var response = await ApiService.post(ApiEndPoint.saveToggle, body: body);

      if (response.statusCode == 200) {
        bool isNowSaved = response.data["data"]["deletedCount"] == null;
        learning.isOnFavorite = isNowSaved;
        update();
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Could not toggle favorite');
      update();
    }
  }

  Future<void> popuparArtist() async {
    try {
      populartArtistIsLoading = true;
      var response = await getPopularArtist();
      if (response != null) {
        popularArtistList = response;
        populartArtistIsLoading = false;
      }
      update();
    } catch (error) {
      populartArtistIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  Future<void> recommendedArt() async {
    try {
      recommendedArtIsLoading = true;
      var response = await getRecommendedArt();
      if (response != null) {
        recommendedArtList = response;
        recommendedArtIsLoading = false;
      }
      update();
    } catch (error) {
      recommendedArtIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

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

  Future<void> exhibition() async {
    try {
      upComingExibitionIsLoading = true;
      var response = await getExibition();
      if (response != null) {
        exhibitionList = response;
        upComingExibitionIsLoading = false;
      }
      update();
    } catch (error) {
      upComingExibitionIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  Future<void> events() async {
    try {
      upComingEventIsLoading = true;
      var response = await getEvents();
      if (response != null) {
        eventsList = response;
        upComingEventIsLoading = false;
      }
      update();
    } catch (error) {
      upComingEventIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  Future<void> fetchLearningMaterials() async {
    try {
      learningMaterialIsLoading = true;
      update();
      final response = await getLearningMaterials(limit: 10);
      if (response != null) {
        learningMaterials = response;
      }
      learningMaterialIsLoading = false;
      update();
    } catch (error) {
      learningMaterialIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  void savedArtListToggle({required int index}) async {
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

  void savedExibitionListToggle({required int index}) async {
    try {
      ExhibitionCardModel? exibition = exhibitionList?[index];
      if (exibition == null) return;

      // // Optional: optimistic UI update (instant toggle before API)
      // art.isOnFavorite = !(art.isOnFavorite ?? false);
      // update();

      Map<String, dynamic> body = {'type': 'Exhibition', 'item': exibition.id};
      var response = await ApiService.post(ApiEndPoint.saveToggle, body: body);

      if (response.statusCode == 200) {
        // Sync based on backend response
        bool isNowSaved = response.data["data"]["deletedCount"] == null;
        exibition.isOnFavorite = isNowSaved;
        update();
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Could not toggle favorite');
      update();
    }
  }

  void savedEventsListToggle({required int index}) async {
    try {
      EventCardModel? event = eventsList?[index];
      if (event == null) return;

      // // Optional: optimistic UI update (instant toggle before API)
      // art.isOnFavorite = !(art.isOnFavorite ?? false);
      // update();

      Map<String, dynamic> body = {'type': 'Event', 'item': event.id};
      var response = await ApiService.post(ApiEndPoint.saveToggle, body: body);

      if (response.statusCode == 200) {
        // Sync based on backend response
        bool isNowSaved = response.data["data"]["deletedCount"] == null;
        event.isOnFavorite = isNowSaved;
        update();
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Could not toggle favorite');
      update();
    }
  }

  @override
  void onInit() {
    featuredArt();
    recommendedArt();
    popuparArtist();
    category();
    exhibition();
    events();
    fetchLearningMaterials();
    super.onInit();
  }
}
