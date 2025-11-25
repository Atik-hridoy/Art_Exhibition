import 'dart:developer';
import 'package:get/get.dart';
import 'package:tasaned_project/utils/helpers/other_helper.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'create_new_event_controller.dart';

class CreateNewEventGalleryController extends GetxController {
  final List<String> imagePaths = [];
  String? videoPath;

  int get photosCount => imagePaths.length;
  static const int maxPhotos = 10;

  Future<void> pickImages() async {
    final remaining = maxPhotos - imagePaths.length;
    if (remaining <= 0) return;
    final picked = await OtherHelper.pickMultipleImage(imageLimit: remaining);
    if (picked.isNotEmpty) {
      imagePaths.addAll(picked);
      update();
    }
  }

  void removeImageAt(int index) {
    if (index >= 0 && index < imagePaths.length) {
      imagePaths.removeAt(index);
      update();
    }
  }

  void removeVideo() {
    videoPath = null;
    update();
  }

  // Save current step images
  void saveCurrentImages() {
    CreateNewEventController.eventData['images'] = imagePaths;
    log('Step 2 images saved: ${imagePaths.length} images');
  }

  // Save as draft functionality
  Future<void> saveAsDraft() async {
    try {
      // Save current images
      saveCurrentImages();
      
      // Set status to DRAFT
      CreateNewEventController.eventData['status'] = 'DRAFT';
      
      log('Saving event as draft with images: ${CreateNewEventController.eventData}');
      
      // Prepare form data
      Map<String, String> body = {};
      CreateNewEventController.eventData.forEach((key, value) {
        if (value != null && value.toString().isNotEmpty && key != 'images') {
          body[key] = value.toString();
        }
      });
      
      // Create draft with first image if available
      if (imagePaths.isNotEmpty) {
        final response = await ApiService.multipart(
          'events',
          body: body,
          imagePath: imagePaths.first,
          imageName: 'images',
        );
        
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Upload additional images if any
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
          log('Event draft with images saved successfully');
          Utils.successSnackBar('Success', 'Event saved as draft');
          
          // Clear stored data
          CreateNewEventController.eventData.clear();
          imagePaths.clear();
          
          // Navigate back to home
          Get.offAllNamed('/userHome');
        } else {
          log('Failed to save draft: ${response.statusCode}');
          Utils.errorSnackBar('Error', 'Failed to save draft');
        }
      } else {
        // Create draft without images
        final response = await ApiService.post(
          'events',
          body: body,
        );
        
        if (response.statusCode == 200 || response.statusCode == 201) {
          log('Event draft saved successfully');
          Utils.successSnackBar('Success', 'Event saved as draft');
          
          // Clear stored data
          CreateNewEventController.eventData.clear();
          imagePaths.clear();
          
          // Navigate back to home
          Get.offAllNamed('/userHome');
        } else {
          log('Failed to save draft: ${response.statusCode}');
          Utils.errorSnackBar('Error', 'Failed to save draft');
        }
      }
      
    } catch (e) {
      log('Error saving draft: $e');
      Utils.errorSnackBar('Error', 'Failed to save draft: $e');
    }
  }

  @override
  void onClose() {
    imagePaths.clear();
    videoPath = null;
    super.onClose();
  }
}
