import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/exibition_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ExhibitionDetailsController extends GetxController {
  bool upComingExibitionIsLoading = false;
  bool isSaved = false;
  Exhibition? exibition;
  String? exibitionId;

  void exibitionDetails() async {
    try {
      upComingExibitionIsLoading = true;
      // TODO: Need to change the  ID parameter
      var response = await getExibitionDetails(id: '68fa0e5cdb0dd5f1b948a6c0');
      if (response != null) {
        exibition = response;
        exibitionId = exibition!.id;
        upComingExibitionIsLoading = false;
      }
      update();
    } catch (error) {
      upComingExibitionIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  Future<void> saveToggle() async {
    try {
      Map<String, dynamic> body = {'type': 'Exhibition', "item": exibitionId};
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

  Future<void> openInBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } catch (e) {
      Utils.errorSnackBar('Error', "Can't open the URL in your device");
    }
  }

  @override
  void onInit() {
    exibitionDetails();
    isSaved = exibition?.isOnFavorite ?? false;
    super.onInit();
  }
}
