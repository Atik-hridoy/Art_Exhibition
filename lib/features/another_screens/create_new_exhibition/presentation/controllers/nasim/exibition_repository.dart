import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tasaned_project/services/api/api_response_model.dart';
import '../../../../../../services/api/api_service.dart';

class ExhibitionRepository {
  // Search artists from API
  static Future<ApiResponseModel> searchArtists({required String searchTerm}) async {
    final url = "http://10.10.7.102:5009/api/v1/users?searchTerm=$searchTerm&role=ARTIST";
    return await ApiService.get(url);
  }

  // Create new exhibition
  static Future<ApiResponseModel> createExhibition({
    required Map<String, dynamic> data,
    required List<String> imagePaths,
    String? videoPath,
  }) async {
    try {
      FormData formData = FormData();

      // Add images (up to 10)
      for (int i = 0; i < imagePaths.length && i < 10; i++) {
        String path = imagePaths[i];
        File file = File(path);
        String fileName = file.path.split('/').last;
        formData.files.add(
          MapEntry('images', await MultipartFile.fromFile(path, filename: fileName)),
        );
      }

      // Add video if exists
      if (videoPath != null && videoPath.isNotEmpty) {
        File videoFile = File(videoPath);
        String videoName = videoFile.path.split('/').last;
        formData.files.add(
          MapEntry('video', await MultipartFile.fromFile(videoPath, filename: videoName)),
        );
      }

      // Add all other data as fields
      data.forEach((key, value) {
        if (value != null) {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });

      final response = await ApiService.post(
        "http://10.10.7.102:5009/api/v1/exhibition",
        body: formData,
      );

      return ApiResponseModel(response.statusCode, response.data);
    } catch (e) {
      if (e is DioException) {
        return ApiResponseModel(
          e.response?.statusCode ?? 500,
          e.response?.data ?? {"message": "Failed to create exhibition"},
        );
      }
      return ApiResponseModel(500, {"message": "Something went wrong"});
    }
  }

  // Update existing exhibition
  static Future<ApiResponseModel> updateExhibition({
    required String exhibitionId,
    required Map<String, dynamic> data,
    required List<String> imagePaths,
    String? videoPath,
  }) async {
    try {
      FormData formData = FormData();

      // Add images (up to 10)
      for (int i = 0; i < imagePaths.length && i < 10; i++) {
        String path = imagePaths[i];
        File file = File(path);
        String fileName = file.path.split('/').last;
        formData.files.add(
          MapEntry('images', await MultipartFile.fromFile(path, filename: fileName)),
        );
      }

      // Add video if exists
      if (videoPath != null && videoPath.isNotEmpty) {
        File videoFile = File(videoPath);
        String videoName = videoFile.path.split('/').last;
        formData.files.add(
          MapEntry('video', await MultipartFile.fromFile(videoPath, filename: videoName)),
        );
      }

      // Add all other data as fields
      data.forEach((key, value) {
        if (value != null) {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });

      final response = await ApiService.patch(
        "http://10.10.7.102:5009/api/v1/exhibition/$exhibitionId",
        body: formData,
      );

      return ApiResponseModel(response.statusCode, response.data);
    } catch (e) {
      if (e is DioException) {
        return ApiResponseModel(
          e.response?.statusCode ?? 500,
          e.response?.data ?? {"message": "Failed to update exhibition"},
        );
      }
      return ApiResponseModel(500, {"message": "Something went wrong"});
    }
  }
}
