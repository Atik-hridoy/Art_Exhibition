import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/saved_art_card_model.dart';
import 'package:tasaned_project/features/data_model/saved_event_card_model.dart';
import 'package:tasaned_project/features/data_model/saved_exibition_card_model.dart';
import 'package:tasaned_project/features/data_model/saved_learning_card_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:tasaned_project/utils/enum/enum.dart';

class SavedController extends GetxController {
  String isSelected = SaveType.arts.value;
  bool savedArtIsLoading = false;
  bool upComingExibitionIsLoading = false;
  bool upComingEventLoading = false;
  bool savedLearningIsLoading = false;
  List<SavedArtCardModel>? savedArtList;
  List<SavedExibitionCardModel>? savedExibitionList;
  List<SavedEventCardModel>? savedEventList;
  List<SavedLearningCardModel>? savedLearningList;

  Future<void> savedArt() async {
    try {
      savedArtIsLoading = true;
      var response = await getSavedArtItem();
      if (response != null) {
        savedArtList = response;
        savedArtIsLoading = false;
      }
      savedArtIsLoading = false;
      update();
    } catch (error) {
      savedArtIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  void savedLearningListToggle({required int index}) async {
    try {
      SavedLearningCardModel? learning = savedLearningList?[index];
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

  Future<void> savedExibition() async {
    try {
      upComingExibitionIsLoading = true;
      var response = await getSavedExibitionItem();
      if (response != null) {
        savedExibitionList = response;
        upComingExibitionIsLoading = false;
      }
      upComingExibitionIsLoading = false;
      update();
    } catch (error) {
      upComingExibitionIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  Future<void> savedEvent() async {
    try {
      upComingEventLoading = true;
      var response = await getSavedEventItem();
      if (response != null) {
        savedEventList = response;
        upComingEventLoading = false;
      }
      upComingEventLoading = false;
      update();
    } catch (error) {
      upComingEventLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  Future<void> savedLearning() async {
    try {
      savedLearningIsLoading = true;
      var response = await getSavedLearningItem();
      if (response != null) {
        savedLearningList = response;
        savedLearningIsLoading = false;
      }
      savedLearningIsLoading = false;
      update();
    } catch (error) {
      savedLearningIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  Future<void> savedArtToggle({required int index}) async {
    try {
      SavedArtCardModel? art = savedArtList?[index];
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
      SavedExibitionCardModel? exibition = savedExibitionList?[index];
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

  void savedEventListToggle({required int index}) async {
    try {
      SavedEventCardModel? event = savedEventList?[index];
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

  updateCategorySelected({type}) {
    isSelected = type;
    update();
  }

  @override
  void onInit() {
    savedArt();
    savedExibition();
    savedEvent();
    savedLearning();
    super.onInit();
  }
}
