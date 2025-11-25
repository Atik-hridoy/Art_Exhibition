import 'dart:developer';
import 'package:flutter/material.dart';
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

  Future<void> getEventDetailsData() async {
    try {
      upComingEventIsLoading = true;
      update();
      
      if (eventId == null || eventId!.isEmpty) {
        upComingEventIsLoading = false;
        update();
        Utils.errorSnackBar('Error', 'Event ID is required');
        return;
      }
      
      log('Fetching event details for ID: $eventId');
      var response = await getEventDetails(eventId: eventId!);
      
      if (response != null) {
        event = response;
        log('Event details loaded successfully: ${event?.title}');
        isSaved = event?.isOnFavorite ?? false;
      } else {
        log('Failed to load event details');
      }
      
      upComingEventIsLoading = false;
      update();
    } catch (error) {
      log('Error fetching event details: $error');
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

  void initialFunction() async {
    // Get eventId from arguments passed from My Events screen
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      eventId = arguments['eventId']?.toString();
      log('Event ID from arguments: $eventId');
    }
    
    if (eventId != null) {
      await getEventDetailsData();
    } else {
      log('No eventId provided in arguments');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Utils.errorSnackBar('Error', 'Event ID not found');
      });
    }
  }

  @override
  void onInit() {
    initialFunction();
    super.onInit();
  }
}
