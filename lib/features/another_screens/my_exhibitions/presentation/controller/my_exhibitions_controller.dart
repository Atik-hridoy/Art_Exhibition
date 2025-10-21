import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/exibition_card_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class MyExhibitionsController extends GetxController {
  bool myExibitionIsLoading = false;
  List<ExhibitionCardModel>? exhibitionList;
  int selectedSort = 0;

  Future<void> exibition() async {
    try {
      myExibitionIsLoading = true;
      var response = await getMyExibition();
      if (response != null) {
        exhibitionList = response;
        myExibitionIsLoading = false;
      }
      update();
    } catch (error) {
      myExibitionIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  void savedExhibitionToggle({required int index}) async {
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

  @override
  void onInit() {
    exibition();
    super.onInit();
  }
}
