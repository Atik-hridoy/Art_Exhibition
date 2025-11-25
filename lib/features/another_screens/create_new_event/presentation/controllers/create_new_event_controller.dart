import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/services/storage/storage_services.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class CreateNewEventController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController overviewController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController visitingHoursController = TextEditingController();
  final TextEditingController venueController = TextEditingController();

  // Store data for passing between screens
  static Map<String, dynamic> eventData = {};

  Future<void> pickStartDate(BuildContext context) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) {
      startDateController.text = _formatDate(date);
      update();
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) {
      endDateController.text = _formatDate(date);
      update();
    }
  }

  String _formatDate(DateTime d) => "${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}";

  // Save current step data
  void saveCurrentStepData() {
    eventData['title'] = titleController.text;
    eventData['description'] = descriptionController.text;
    eventData['overview'] = overviewController.text;
    eventData['startDate'] = _convertDateFormat(startDateController.text);
    eventData['endDate'] = _convertDateFormat(endDateController.text);
    eventData['visitingHour'] = visitingHoursController.text;
    eventData['venue'] = venueController.text;
    eventData['creatorId'] = LocalStorage.userId;
    eventData['status'] = 'DRAFT'; // Set status to DRAFT
    log('Step 1 data saved: $eventData');
  }

  // Save as draft functionality
  Future<void> saveAsDraft() async {
    try {
      // Save current step data
      saveCurrentStepData();
      
      // Set status to DRAFT
      eventData['status'] = 'DRAFT';
      
      log('Saving event as draft: $eventData');
      
      // Create draft without images for now
      Map<String, String> body = {};
      eventData.forEach((key, value) {
        if (value != null && value.toString().isNotEmpty && key != 'images') {
          body[key] = value.toString();
        }
      });
      
      // Call API to create draft
      final response = await ApiService.post(
        'events',
        body: body,
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Event draft saved successfully');
        Utils.successSnackBar('Success', 'Event saved as draft');
        
        // Clear stored data
        eventData.clear();
        
        // Navigate back to home
        Get.offAllNamed('/userHome');
      } else {
        log('Failed to save draft: ${response.statusCode}');
        Utils.errorSnackBar('Error', 'Failed to save draft');
      }
      
    } catch (e) {
      log('Error saving draft: $e');
      Utils.errorSnackBar('Error', 'Failed to save draft: $e');
    }
  }

  // Convert MM/DD/YYYY to YYYY-MM-DD format
  String _convertDateFormat(String date) {
    if (date.isEmpty) return '';
    final parts = date.split('/');
    if (parts.length == 3) {
      return '${parts[2]}-${parts[0].padLeft(2, '0')}-${parts[1].padLeft(2, '0')}';
    }
    return date;
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    overviewController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    visitingHoursController.dispose();
    venueController.dispose();
    eventData.clear();
    super.onClose();
  }
}
