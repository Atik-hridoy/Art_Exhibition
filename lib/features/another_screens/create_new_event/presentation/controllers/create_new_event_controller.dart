import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/services/storage/storage_services.dart';

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
    eventData['status'] = 'UPCOMING';
    log('Step 1 data saved: $eventData');
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
