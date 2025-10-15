import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/features_art_card_model.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class HomeController extends GetxController {
  List<FeaturesArtCardModel>? featureArtList;
  bool featureArtIsLoading = false;
  bool categoryIsLoading = false;
  bool populartArtistIsLoading = false;
  bool recommandedArtIsLoading = false;
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

  @override
  void onInit() {
    featuredArt();
    super.onInit();
  }
}
