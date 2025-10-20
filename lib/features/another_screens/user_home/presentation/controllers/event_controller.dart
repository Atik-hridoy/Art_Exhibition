import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/event_card_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class EventController extends GetxController {
  List<EventCardModel>? eventsList;
  bool upComingEventIsLoading = false;

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
    events();
    super.onInit();
  }
}
