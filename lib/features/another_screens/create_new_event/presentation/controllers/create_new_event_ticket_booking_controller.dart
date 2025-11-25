import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/services/api/api_response_model.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:tasaned_project/component/pop_up/create_exhibition_success_popup.dart';
import 'create_new_event_controller.dart';

class CreateNewEventTicketBookingController extends GetxController {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  
  bool isCreating = false;

  // Repository function wrapper
  Future<ApiResponseModel?> createEventWithImages({
    required Map<String, dynamic> eventData,
    required List<String> imagePaths,
  }) async {
    try {
      log('Creating event with ${imagePaths.length} images');
      
      // Prepare form data
      Map<String, String> body = {};
      eventData.forEach((key, value) {
        if (value != null && value.toString().isNotEmpty && key != 'images') {
          body[key] = value.toString();
        }
      });
      
      // Create event with first image if available
      if (imagePaths.isNotEmpty) {
        final response = await ApiService.multipart(
          'events',
          body: body,
          imagePath: imagePaths.first,
          imageName: 'images',
        );
        
        if (response.statusCode == 200 || response.statusCode == 201) {
          // If there are more images, upload them separately
          if (imagePaths.length > 1) {
            final eventId = response.data['data']?['_id'];
            if (eventId != null) {
              for (int i = 1; i < imagePaths.length; i++) {
                await ApiService.multipart(
                  'events/$eventId',
                  body: {},
                  imagePath: imagePaths[i],
                  imageName: 'images',
                );
              }
            }
          }
          log('Event created successfully');
          return response;
        } else {
          log('Failed to create event: ${response.statusCode}');
          return response;
        }
      } else {
        // Create event without images
        final response = await ApiService.post(
          'events',
          body: body,
        );
        
        if (response.statusCode == 200 || response.statusCode == 201) {
          log('Event created successfully without images');
          return response;
        } else {
          log('Failed to create event: ${response.statusCode}');
          return response;
        }
      }
    } catch (e) {
      log('Error creating event: $e');
      Utils.errorSnackBar('An error with repository', 'Please contact with developer $e');
      return null;
    }
  }

  // Save final data and create event
  Future<void> createEvent() async {
    try {
      isCreating = true;
      update();
      
      // Add ticket and booking info to event data
      CreateNewEventController.eventData['ticketPrice'] = priceController.text;
      CreateNewEventController.eventData['bookingUrl'] = urlController.text;
      CreateNewEventController.eventData['status'] = 'UPCOMING'; // Set to UPCOMING for publish
      
      log('Final event data: ${CreateNewEventController.eventData}');
      
      // Prepare form data for API
      Map<String, String> body = {};
      CreateNewEventController.eventData.forEach((key, value) {
        if (value != null && value.toString().isNotEmpty && key != 'images') {
          body[key] = value.toString();
        }
      });
      
      // Get image paths
      List<String> imagePaths = [];
      if (CreateNewEventController.eventData['images'] != null) {
        imagePaths = List<String>.from(CreateNewEventController.eventData['images']);
      }
      
      log('Creating event with ${imagePaths.length} images');
      
      // Call API
      final response = await createEventWithImages(
        eventData: CreateNewEventController.eventData,
        imagePaths: imagePaths,
      );
      
      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        log('Event created successfully');
        // Clear stored data
        CreateNewEventController.eventData.clear();
        
        // Show success popup
        CreateNewExhibitionSuccessPopup.show();
      } else {
        log('Failed to create event: ${response?.statusCode}');
        Utils.errorSnackBar('Error', 'Failed to create event');
      }
      
    } catch (e) {
      log('Error creating event: $e');
      Utils.errorSnackBar('Error', 'Failed to create event: $e');
    } finally {
      isCreating = false;
      update();
    }
  }

  // Save as draft functionality
  Future<void> saveAsDraft() async {
    try {
      // Add ticket and booking info to event data
      CreateNewEventController.eventData['ticketPrice'] = priceController.text;
      CreateNewEventController.eventData['bookingUrl'] = urlController.text;
      CreateNewEventController.eventData['status'] = 'DRAFT'; // Set to DRAFT
      
      log('Saving event as draft with final data: ${CreateNewEventController.eventData}');
      
      // Prepare form data
      Map<String, String> body = {};
      CreateNewEventController.eventData.forEach((key, value) {
        if (value != null && value.toString().isNotEmpty && key != 'images') {
          body[key] = value.toString();
        }
      });
      
      // Get image paths
      List<String> imagePaths = [];
      if (CreateNewEventController.eventData['images'] != null) {
        imagePaths = List<String>.from(CreateNewEventController.eventData['images']);
      }
      
      // Call API to create draft
      final response = await createEventWithImages(
        eventData: CreateNewEventController.eventData,
        imagePaths: imagePaths,
      );
      
      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        log('Event draft saved successfully');
        Utils.successSnackBar('Success', 'Event saved as draft');
        
        // Clear stored data
        CreateNewEventController.eventData.clear();
        
        // Navigate back to home
        Get.offAllNamed('/userHome');
      } else {
        log('Failed to save draft: ${response?.statusCode}');
        Utils.errorSnackBar('Error', 'Failed to save draft');
      }
      
    } catch (e) {
      log('Error saving draft: $e');
      Utils.errorSnackBar('Error', 'Failed to save draft: $e');
    }
  }

  @override
  void onClose() {
    priceController.dispose();
    urlController.dispose();
    super.onClose();
  }
}
