import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/create_new_exhibition/presentation/controllers/nasim/artist_model.dart';
import 'package:tasaned_project/features/another_screens/create_new_exhibition/presentation/controllers/nasim/exibition_repository.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';
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

  // Field selection
  final List<String> fieldOptions = ['Art', 'Photography', 'Sculpture', 'Mixed', 'Other'];
  String selectedField = 'Art';

  // Gallery data
  final List<String> imagePaths = [];
  String? videoPath;
  String? uploadedVideoUrl; // Store uploaded video URL from server
  bool isUploadingVideo = false;
  double videoUploadProgress = 0.0;
  int currentChunk = 0;
  int totalChunks = 0;
  static const int maxPhotos = 10;
  static const int videoChunkSize = 3 * 1024 * 1024; // 3 MB chunks

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
      Utils.errorSnackBar('Limit Reached', 'You can upload maximum $maxPhotos photos');
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
    try {
      final picked = await OtherHelper.pickVideoFromGallery();
      if (picked != null && picked.isNotEmpty) {
        videoPath = picked;
        update();
        // Upload video immediately after picking
        await _uploadVideo(picked);
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Failed to pick video');
    }
  }

  Future<void> _uploadVideo(String videoFilePath) async {
    RandomAccessFile? raf;
    try {
      isUploadingVideo = true;
      videoUploadProgress = 0.0;
      currentChunk = 0;
      update();

      final file = File(videoFilePath);
      if (!file.existsSync()) {
        Utils.errorSnackBar('Video not found', 'Please pick the file again.');
        isUploadingVideo = false;
        update();
        return;
      }

      final totalBytes = await file.length();
      totalChunks = (totalBytes / videoChunkSize).ceil();
      raf = file.openSync(mode: FileMode.read);

      final fileName = file.uri.pathSegments.last;

      for (var index = 0; index < totalChunks; index++) {
        final bytesRead = min(videoChunkSize, totalBytes - index * videoChunkSize);
        final chunkBytes = raf.readSync(bytesRead);

        final formData = dio.FormData.fromMap({
          'chunkIndex': index,
          'totalChunks': totalChunks,
          'originalname': fileName,
          'chunk': dio.MultipartFile.fromBytes(
            chunkBytes,
            filename: '$fileName.part$index',
          ),
        });

        final response = await ApiService.post(
          ApiEndPoint.uoloadVideo,
          body: formData,
          header: {'Content-Type': 'multipart/form-data'},
        );

        if (response.statusCode == 200) {
          currentChunk = index + 1;
          videoUploadProgress = currentChunk / totalChunks;

          final payload = response.data['data'] ?? response.data;
          if (payload is Map && payload['videoUrl'] != null) {
            uploadedVideoUrl = payload['videoUrl'].toString();
          } else if (payload is String) {
            uploadedVideoUrl = payload;
          }

          update();
        } else {
          throw Exception(response.data['message'] ?? 'Chunk upload failed');
        }
      }

      Utils.successSnackBar('Success', 'Video uploaded successfully');
    } catch (e) {
      Utils.errorSnackBar('Upload failed', e.toString());
      videoPath = null;
      uploadedVideoUrl = null;
    } finally {
      raf?.closeSync();
      isUploadingVideo = false;
      update();
    }
  }

  void removeVideo() {
    videoPath = null;
    uploadedVideoUrl = null;
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
        Utils.errorSnackBar('Error', response.message);
        visibleArtists = [];
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Failed to search artists');
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
          Utils.errorSnackBar('Required', 'Please enter exhibition title');
          return false;
        }
        if (descriptionCtrl.text.trim().isEmpty) {
          Utils.errorSnackBar('Required', 'Please enter description');
          return false;
        }
        if (startDateCtrl.text.trim().isEmpty) {
          Utils.errorSnackBar('Required', 'Please select start date');
          return false;
        }
        if (endDateCtrl.text.trim().isEmpty) {
          Utils.errorSnackBar('Required', 'Please select end date');
          return false;
        }
        if (venueCtrl.text.trim().isEmpty) {
          Utils.errorSnackBar('Required', 'Please enter venue');
          return false;
        }
        return true;

      case 1: // Gallery
        if (imagePaths.isEmpty) {
          Utils.errorSnackBar('Required', 'Please upload at least one image');
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
          Utils.errorSnackBar('Required', 'Please enter ticket price');
          return false;
        }
        if (bookingUrlCtrl.text.trim().isEmpty) {
          Utils.errorSnackBar('Required', 'Please enter booking URL');
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

      // Validate and format booking URL
      String bookingUrl = bookingUrlCtrl.text.trim();
      if (!bookingUrl.startsWith('http://') && !bookingUrl.startsWith('https://')) {
        bookingUrl = 'https://$bookingUrl';
      }

      // Prepare exhibition data
      final Map<String, dynamic> exhibitionData = {
        'title': titleCtrl.text.trim(),
        'description': descriptionCtrl.text.trim(),
        'startDate': startDate,
        'endDate': endDate,
        'visitingHour': visitingHoursCtrl.text.trim(),
        'venue': venueCtrl.text.trim(),
        'field': selectedField,
        'bookingUrl': bookingUrl,
        'ticketPrice': int.tryParse(priceCtrl.text.trim()) ?? 0,
        'status': 'Upcoming',
      };

      // Add artists if selected
      if (selectedArtists.isNotEmpty) {
        exhibitionData['artists'] = jsonEncode(
          selectedArtists.map((a) => a.toJson()).toList(),
        );
      }

      // Add uploaded video URL if available
      if (uploadedVideoUrl != null && uploadedVideoUrl!.isNotEmpty) {
        exhibitionData['video'] = uploadedVideoUrl;
      }

      // if (selectedArtists.isNotEmpty) {
      //   exhibitionData['artists'] = selectedArtists.map((a) => a.toJson()).toList();
      // }

      // Call repository
      final response = await ExhibitionRepository.createExhibition(
        data: exhibitionData,
        imagePaths: imagePaths,
        videoPath: null, // Don't send local path, use uploaded URL instead
      );

      if (response.isSuccess) {
        Get.back();
        Utils.successSnackBar('Success', 'Exhibition created successfully');
        // Show success popup if needed
      } else {
        Utils.errorSnackBar('Error', response.message);
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Failed to create exhibition');
    } finally {
      isSubmitting = false;
      update();
    }
  }

  void saveAsDraft() {
    Utils.successSnackBar('Info', 'Draft saved locally');
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
