import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/saved_art_card_model.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:tasaned_project/utils/enum/enum.dart';

class SavedController extends GetxController {
  String isSelected = SaveType.arts.value;
  bool savedArtIsLoading = false;
  List<SavedArtCardModel>? savedArtList;

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
