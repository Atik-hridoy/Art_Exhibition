import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/create_new_exhibition/presentation/controllers/nasim/artist_model.dart';
import 'package:tasaned_project/features/another_screens/create_new_exhibition/presentation/controllers/nasim/exibition_repository.dart';
import 'package:tasaned_project/utils/helpers/other_helper.dart';

class CreateExhibitionController extends GetxController {
  // Step tracker
  int currentStep = 0;

  // Basic Information controllers
  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final startDateCtrl = TextEditingController();
  final endDateCtrl = TextEditingController();
  final visitingHoursCtrl = TextEditingController();
  final venueCtrl = TextEditingController();
  final galleryCtrl = TextEditingController();

  // Gallery data
  final List<String> imagePaths = [];
  String? videoPath;
  static const int maxPhotos = 10;

  // Feature Artist data
  List<ArtistModel> allArtists = [];
  List<ArtistModel> visibleArtists = [];
  final List<ArtistModel> selectedArtists = [];
  bool isLoadingArtists = false;

  // Ticket & Booking controllers
  final priceCtrl = TextEditingController();
  final bookingUrlCtrl = TextEditingController();

  // Loading state
  bool isSubmitting = false;

  int get photosCount => imagePaths.length;

  @override
  void onInit() {
    super.onInit();
    // Initialize with empty artist list
    visibleArtists = [];
  }

  // ========== STEP NAVIGATION ========== //
  void goToNextStep() {
    if (currentStep < 3) {
      if (_validateCurrentStep()) {
        currentStep++;
        update();
      }
    }
  }

  void goToPreviousStep() {
    if (currentStep > 0) {
      currentStep--;
      update();
    }
  }

  // ========== STEP 1: BASIC INFORMATION ========== //
  Future<void> pickStartDate() async {
    await OtherHelper.openDatePickerDialog(startDateCtrl);
    update();
  }

  Future<void> pickEndDate() async {
    await OtherHelper.openDatePickerDialog(endDateCtrl);
    update();
  }

  // ========== STEP 2: GALLERY ========== //
  Future<void> pickImages() async {
    final remaining = maxPhotos - imagePaths.length;
    if (remaining <= 0) {
      Get.snackbar('Limit Reached', 'You can upload maximum $maxPhotos photos');
      return;
    }
    final picked = await OtherHelper.pickMultipleImage(imageLimit: remaining);
    if (picked.isNotEmpty) {
      imagePaths.addAll(picked);
      update();
    }
  }

  void removeImageAt(int i) {
    if (i >= 0 && i < imagePaths.length) {
      imagePaths.removeAt(i);
      update();
    }
  }

  Future<void> pickVideo() async {
    // Implement video picker using OtherHelper or similar
    // For now, placeholder
    Get.snackbar('Info', 'Video picker to be implemented');
  }

  void removeVideo() {
    videoPath = null;
    update();
  }

  // ========== STEP 3: FEATURE ARTIST ========== //
  Future<void> searchArtists(String searchTerm) async {
    if (searchTerm.trim().isEmpty) {
      visibleArtists = [];
      update();
      return;
    }

    isLoadingArtists = true;
    update();

    try {
      final response = await ExhibitionRepository.searchArtists(
        searchTerm: searchTerm.trim(),
      );

      if (response.isSuccess) {
        final List<dynamic> data = response.data['data'] ?? [];
        allArtists = data.map((json) => ArtistModel.fromJson(json)).toList();
        visibleArtists = List.from(allArtists);
      } else {
        Get.snackbar('Error', response.message);
        visibleArtists = [];
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to search artists');
      visibleArtists = [];
    } finally {
      isLoadingArtists = false;
      update();
    }
  }

  bool isArtistSelected(ArtistModel artist) {
    return selectedArtists.any((a) => a.id == artist.id);
  }

  void toggleArtistSelection(ArtistModel artist) {
    final index = selectedArtists.indexWhere((a) => a.id == artist.id);
    if (index >= 0) {
      selectedArtists.removeAt(index);
    } else {
      selectedArtists.add(artist);
    }
    update();
  }

  void removeArtistSelection(ArtistModel artist) {
    selectedArtists.removeWhere((a) => a.id == artist.id);
    update();
  }

  // ========== VALIDATION ========== //
  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0: // Basic Information
        if (titleCtrl.text.trim().isEmpty) {
          Get.snackbar('Required', 'Please enter exhibition title');
          return false;
        }
        if (descriptionCtrl.text.trim().isEmpty) {
          Get.snackbar('Required', 'Please enter description');
          return false;
        }
        if (startDateCtrl.text.trim().isEmpty) {
          Get.snackbar('Required', 'Please select start date');
          return false;
        }
        if (endDateCtrl.text.trim().isEmpty) {
          Get.snackbar('Required', 'Please select end date');
          return false;
        }
        if (venueCtrl.text.trim().isEmpty) {
          Get.snackbar('Required', 'Please enter venue');
          return false;
        }
        return true;

      case 1: // Gallery
        if (imagePaths.isEmpty) {
          Get.snackbar('Required', 'Please upload at least one image');
          return false;
        }
        // TODO: Implement video later
        // if (videoPath == null || videoPath!.isEmpty) {
        //   Get.snackbar('Required', 'Please upload a video for virtual tour');
        //   return false;
        // }
        return true;

      case 2: // Feature Artist
        // Artists are optional, but we can add validation if needed
        return true;

      case 3: // Ticket & Booking
        if (priceCtrl.text.trim().isEmpty) {
          Get.snackbar('Required', 'Please enter ticket price');
          return false;
        }
        if (bookingUrlCtrl.text.trim().isEmpty) {
          Get.snackbar('Required', 'Please enter booking URL');
          return false;
        }
        return true;

      default:
        return true;
    }
  }

  // ========== SUBMIT EXHIBITION ========== //
  Future<void> createExhibition() async {
    if (!_validateCurrentStep()) return;

    isSubmitting = true;
    update();

    try {
      String parseDate(String dateString) {
        final parts = dateString.split('/');
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);

        // Create DateTime in UTC with default time 00:00:00
        final dateTime = DateTime.utc(year, month, day);

        // Return in ISO 8601 format
        return dateTime.toIso8601String();
      }

      // Format the dates correctly
      String startDate = parseDate(startDateCtrl.text);
      String endDate = parseDate(endDateCtrl.text);

      // Prepare exhibition data
      final Map<String, dynamic> exhibitionData = {
        'title': titleCtrl.text.trim(),
        'description': descriptionCtrl.text.trim(),
        'startDate': startDate,
        'endDate': endDate,
        'visitingHour': visitingHoursCtrl.text.trim(),
        'venue': venueCtrl.text.trim(),
        'field': 'Artss', //  galleryCtrl.text.trim(),
        'bookingUrl': bookingUrlCtrl.text.trim(),
        'ticketPrice': int.tryParse(priceCtrl.text.trim()) ?? 0,
        'status': 'Upcoming',
      };

      // Add artists if selected
      if (selectedArtists.isNotEmpty) {
        exhibitionData['artists'] = jsonEncode(
          selectedArtists.map((a) => a.toJson()).toList(),
        );
      }

      // if (selectedArtists.isNotEmpty) {
      //   exhibitionData['artists'] = selectedArtists.map((a) => a.toJson()).toList();
      // }

      // Call repository
      final response = await ExhibitionRepository.createExhibition(
        data: exhibitionData,
        imagePaths: imagePaths,
        videoPath: videoPath,
      );

      if (response.isSuccess) {
        Get.back();
        Get.snackbar('Success', 'Exhibition created successfully');
        // Show success popup if needed
      } else {
        Get.snackbar('Error', response.message);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to create exhibition');
    } finally {
      isSubmitting = false;
      update();
    }
  }

  void saveAsDraft() {
    Get.snackbar('Info', 'Draft saved locally');
    Get.back();
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descriptionCtrl.dispose();
    startDateCtrl.dispose();
    endDateCtrl.dispose();
    visitingHoursCtrl.dispose();
    venueCtrl.dispose();
    galleryCtrl.dispose();
    priceCtrl.dispose();
    bookingUrlCtrl.dispose();
    super.onClose();
  }
}
