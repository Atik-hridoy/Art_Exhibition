import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/event_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsController extends GetxController {
  bool upComingEventIsLoading = false;
  bool isSaved = false;
  EventModel? event;
  String? eventId;

  void exibitionDetails() async {
    try {
      upComingEventIsLoading = true;
      // TODO: Need to change the  ID parameter
      var response = await getEventDetails(eventId: '68ca6147969c0da069ba93e1');
      if (response != null) {
        event = response;
        eventId = event!.id;
        upComingEventIsLoading = false;
      }
      update();
    } catch (error) {
      upComingEventIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  Future<void> saveToggle() async {
    try {
      Map<String, dynamic> body = {'type': 'Event', "item": eventId};
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
    isSaved = event?.isOnFavorite ?? false;
    super.onInit();
  }
}
