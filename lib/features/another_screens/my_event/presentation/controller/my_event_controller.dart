import 'dart:developer';
import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/event_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class MyEventController extends GetxController {
  bool myEventIsLoading = false;
  List<EventModel>? eventList;
  int selectedSort = 0;

  Future<void> getMyEvents() async {
    try {
      myEventIsLoading = true;
      update();
      log('Fetching my events...');
      var response = await getMyEvent();
      log('My events response: $response');
      eventList = response;
      myEventIsLoading = false;
      log('My events count: ${eventList?.length ?? 0}');
      update();
    } catch (error) {
      log('Error fetching my events: $error');
      myEventIsLoading = false;
      eventList = null;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  void savedEventToggle({required int index}) async {
    try {
      EventModel? event = eventList?[index];
      if (event == null) return;

      Map<String, dynamic> body = {'type': 'Event', 'item': event.id};
      var response = await ApiService.post(ApiEndPoint.saveToggle, body: body);

      if (response.statusCode == 200) {
        // Toggle completed successfully
        // Note: EventModel doesn't have isOnFavorite field, so we just update the UI
        update();
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Could not toggle favorite');
      update();
    }
  }

  @override
  void onInit() {
    getMyEvents();
    super.onInit();
  }
}
