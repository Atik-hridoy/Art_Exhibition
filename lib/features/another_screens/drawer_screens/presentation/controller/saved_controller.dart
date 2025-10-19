import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/saved_art_card_model.dart';
import 'package:tasaned_project/features/data_model/saved_exibition_card_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:tasaned_project/utils/enum/enum.dart';

class SavedController extends GetxController {
  String isSelected = SaveType.arts.value;
  bool savedArtIsLoading = false;
  bool upComingExibitionIsLoading = false;
  List<SavedArtCardModel>? savedArtList;
  List<SavedExibitionCardModel>? savedExibitionList;

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

  updateCategorySelected({type}) {
    isSelected = type;
    update();
  }

  @override
  void onInit() {
    savedArt();
    super.onInit();
  }
}
