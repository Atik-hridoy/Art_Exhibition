import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/services/storage/storage_keys.dart';
import 'package:tasaned_project/services/storage/storage_services.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:tasaned_project/utils/helpers/other_helper.dart';

class UploadNewLessonController extends GetxController {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  String? videoPath;
  String? imagePath;
  bool isUploadingVideo = false;
  double uploadProgress = 0;
  List<VideoChunkInfo> chunkSummaries = [];
  String? uploadedVideoUrl;
  double? videoDuration;
  bool isPublishing = false;

  Future<void> pickVideo() async {
    final path = await OtherHelper.pickVideoFromGallery();
    if (path != null && path.isNotEmpty) {
      videoPath = path;
      uploadedVideoUrl = null;
      videoDuration = null;
      chunkSummaries = [];
      update();
      await _uploadVideoInChunks(path);
    }
  }

  Future<void> pickImage() async {
    final path = await OtherHelper.openGallery();
    if (path != null && path.isNotEmpty) {
      imagePath = path;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadDraft();
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descriptionCtrl.dispose();
    super.onClose();
  }

  Future<void> _uploadVideoInChunks(String path) async {
    RandomAccessFile? raf;
    try {
      isUploadingVideo = true;
      uploadProgress = 0;
      chunkSummaries = [];
      update();

      final file = File(path);
      if (!file.existsSync()) {
        Utils.errorSnackBar('Video not found', 'Please pick the file again.');
        return;
      }

      final totalBytes = await file.length();
      const chunkSize = 3 * 1024 * 1024; // 3 MB
      final totalChunks = (totalBytes / chunkSize).ceil();
      raf = file.openSync(mode: FileMode.read);

      for (var index = 0; index < totalChunks; index++) {
        final bytesRead = min(chunkSize, totalBytes - index * chunkSize);
        final chunkBytes = raf.readSync(bytesRead);
        final chunkLabel = 'Chunk ${index + 1}/$totalChunks';
        final chunkInfo = VideoChunkInfo(
          label: chunkLabel,
          sizeInBytes: bytesRead,
          isUploaded: false,
        );
        chunkSummaries.add(chunkInfo);
        update();

        final originalName = file.uri.pathSegments.last;
        final formData = dio.FormData.fromMap({
          'chunkIndex': index,
          'totalChunks': totalChunks,
          'originalname': originalName,
          'chunk': dio.MultipartFile.fromBytes(
            chunkBytes,
            filename: '$originalName.part$index',
          ),
        });

        final response = await ApiService.post(
          ApiEndPoint.uoloadVideo,
          body: formData,
          header: {'Content-Type': 'multipart/form-data'},
        );

        if (response.statusCode == 200) {
          chunkSummaries[index] = chunkSummaries[index].copyWith(isUploaded: true);
          uploadProgress = (index + 1) / totalChunks;

          final payload = response.data['data'] ?? response.data;
          if (payload is Map && payload['videoUrl'] != null) {
            uploadedVideoUrl = _normalizeVideoUrl(payload['videoUrl'].toString());
            final durationValue = payload['duration'];
            if (durationValue is num) {
              videoDuration = durationValue.toDouble();
            }
          }
          update();
        } else {
          throw Exception(response.data['message'] ?? 'Chunk upload failed');
        }
      }

      Utils.successSnackBar('Success', 'Video uploaded successfully.');
    } catch (e) {
      Utils.errorSnackBar('Upload failed', e.toString());
    } finally {
      raf?.closeSync();
      isUploadingVideo = false;
      update();
    }
  }

  Future<void> publishLesson() async {
    final title = titleCtrl.text.trim();
    final description = descriptionCtrl.text.trim();

    if (title.isEmpty || description.isEmpty) {
      Utils.errorSnackBar('Missing info', 'Title and description are required.');
      return;
    }

    if (isUploadingVideo) {
      Utils.errorSnackBar('Please wait', 'Video upload still in progress.');
      return;
    }

    if (uploadedVideoUrl == null || uploadedVideoUrl!.isEmpty) {
      Utils.errorSnackBar('Video required', 'Upload a video before publishing.');
      return;
    }

    if (LocalStorage.userId.isEmpty) {
      await LocalStorage.getAllPrefData();
    }

    if (LocalStorage.userId.isEmpty) {
      Utils.errorSnackBar('Unauthorized', 'User information not found.');
      return;
    }

    final tutorials = [
      {
        'title': 'Basics of Abstract Shapes',
        'description': 'Learn how to paint basic abstract shapes using acrylics.',
        'videoUrl': uploadedVideoUrl,
        if (videoDuration != null) 'duration': videoDuration,
      },
      {
        'title': 'Color Theory in Abstract',
        'description': 'Understanding color mixing and contrasts in abstract painting.',
      },
      {
        'title': 'Final Composition Project',
        'description': 'Put your skills together to create a complete abstract painting.',
      },
    ];

    final body = {
      'creatorId': LocalStorage.userId,
      'title': title,
      'description': description,
      'tutorials': tutorials,
    };

    try {
      isPublishing = true;
      update();

      final response = await ApiService.post(ApiEndPoint.postLearningMatrials, body: body);
      debugPrint('Publish response => ${response.data}');

      if (response.statusCode == 200) {
        Utils.successSnackBar('Success', response.message);
        await LocalStorage.remove(LocalStorageKeys.uploadLessonDraft);
      } else {
        Utils.errorSnackBar('Failed', response.message);
      }
    } catch (e) {
      Utils.errorSnackBar('Publish failed', e.toString());
    } finally {
      isPublishing = false;
      update();
    }
  }

  String _normalizeVideoUrl(String url) {
    if (url.startsWith('http')) return url;
    final base = ApiEndPoint.imageUrl.endsWith('/')
        ? ApiEndPoint.imageUrl.substring(0, ApiEndPoint.imageUrl.length - 1)
        : ApiEndPoint.imageUrl;
    return url.startsWith('/') ? '$base$url' : '$base/$url';
  }

  Future<void> saveDraft() async {
    final draftPayload = {
      'title': titleCtrl.text,
      'description': descriptionCtrl.text,
      'videoPath': videoPath,
      'uploadedVideoUrl': uploadedVideoUrl,
      'videoDuration': videoDuration,
      'imagePath': imagePath,
    };

    try {
      await LocalStorage.setString(
        LocalStorageKeys.uploadLessonDraft,
        jsonEncode(draftPayload),
      );
      Utils.successSnackBar('Saved', 'Draft stored locally.');
    } catch (e) {
      Utils.errorSnackBar('Save failed', e.toString());
    }
  }

  Future<void> _loadDraft() async {
    try {
      final saved = await LocalStorage.getString(LocalStorageKeys.uploadLessonDraft);
      if (saved == null || saved.isEmpty) return;

      final decoded = jsonDecode(saved);
      if (decoded is! Map) return;

      titleCtrl.text = decoded['title']?.toString() ?? '';
      descriptionCtrl.text = decoded['description']?.toString() ?? '';
      videoPath = decoded['videoPath']?.toString();
      uploadedVideoUrl = decoded['uploadedVideoUrl']?.toString();
      final durationValue = decoded['videoDuration'];
      if (durationValue is num) {
        videoDuration = durationValue.toDouble();
      }
      imagePath = decoded['imagePath']?.toString();
      update();
    } catch (e) {
      debugPrint('Failed to load draft => $e');
    }
  }
}

class VideoChunkInfo {
  final String label;
  final int sizeInBytes;
  final bool isUploaded;

  const VideoChunkInfo({
    required this.label,
    required this.sizeInBytes,
    required this.isUploaded,
  });

  VideoChunkInfo copyWith({bool? isUploaded}) {
    return VideoChunkInfo(
      label: label,
      sizeInBytes: sizeInBytes,
      isUploaded: isUploaded ?? this.isUploaded,
    );
  }
}
