import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/exibition_card_model.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class ExibitionController extends GetxController {
  bool upComingExibitionIsLoading = false;
  List<ExhibitionCardModel>? exhibitionList;
  int selectedSort = 0;

  Future<void> exibition() async {
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

  @override
  void onInit() {
    exibition();
    super.onInit();
  }
}
