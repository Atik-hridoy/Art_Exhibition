import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import '../../config/api/api_end_point.dart';
import '../../utils/constants/app_string.dart';
import '../../utils/log/api_log.dart';
import '../storage/storage_services.dart';
import 'api_response_model.dart';

class ApiService {
  static final Dio _dio = _getMyDio();

  /// ========== [ HTTP METHODS ] ========== ///
  static Future<ApiResponseModel> post(
    String url, {
    dynamic body,
    Map<String, String>? header,
  }) => _request(url, "POST", body: body, header: header);

  static Future<ApiResponseModel> get(String url, {Map<String, String>? header}) =>
      _request(url, "GET", header: header);

  static Future<ApiResponseModel> put(
    String url, {
    dynamic body,
    Map<String, String>? header,
  }) => _request(url, "PUT", body: body, header: header);

  static Future<ApiResponseModel> patch(
    String url, {
    dynamic body,
    Map<String, String>? header,
  }) => _request(url, "PATCH", body: body, header: header);

  static Future<ApiResponseModel> delete(
    String url, {
    dynamic body,
    Map<String, String>? header,
  }) => _request(url, "DELETE", body: body, header: header);

  static Future<ApiResponseModel> multipart(
    String url, {
    Map<String, String>? header,
    Map<String, String> body = const {},
    String method = "POST",
    String imageName = 'image',
    String? imagePath,
  }) async {
    FormData formData = FormData();
    if (imagePath != null && imagePath.isNotEmpty) {
      final file = File(imagePath);
      final extension = file.path.split('.').last.toLowerCase();
      final originalName = file.uri.pathSegments.isNotEmpty
          ? file.uri.pathSegments.last
          : "$imageName.$extension";
      final mimeType = lookupMimeType(imagePath);

      formData.files.add(
        MapEntry(
          imageName,
          await MultipartFile.fromFile(
            imagePath,
            filename: originalName,
            contentType: mimeType != null
                ? DioMediaType.parse(mimeType)
                : DioMediaType.parse("image/jpeg"),
          ),
        ),
      );
    }

    body.forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    final requestHeader = <String, String>{...?(header)};
    requestHeader['Content-Type'] = "multipart/form-data";

    return _request(url, method, body: formData, header: requestHeader);
  }

  /// ========== [ MULTIPART WITH MULTIPLE FILES AND JSON BODY ] ========== ///
  static Future<ApiResponseModel> multipartMultipleWithJson(
    String url, {
    Map<String, String>? header,
    Map<String, dynamic> body = const {},
    String method = "POST",
    String imageName = 'images',
    List<String> imagePaths = const [],
  }) async {
    FormData formData = FormData();

    // Add multiple files with the same field name
    for (String imagePath in imagePaths) {
      if (imagePath.isNotEmpty) {
        final file = File(imagePath);
        final extension = file.path.split('.').last.toLowerCase();
        final originalName = file.uri.pathSegments.isNotEmpty
            ? file.uri.pathSegments.last
            : "image_${DateTime.now().millisecondsSinceEpoch}.$extension";
        final mimeType = lookupMimeType(imagePath);

        formData.files.add(
          MapEntry(
            imageName,
            await MultipartFile.fromFile(
              imagePath,
              filename: originalName,
              contentType: mimeType != null
                  ? DioMediaType.parse(mimeType)
                  : DioMediaType.parse("image/jpeg"),
            ),
          ),
        );
      }
    }

    // Add JSON-serializable fields properly
    body.forEach((key, value) {
      if (value is bool) {
        // Send booleans as lowercase strings that Zod can parse
        formData.fields.add(MapEntry(key, value ? "true" : "false"));
      } else if (value is Map) {
        // Send objects as JSON strings
        formData.fields.add(MapEntry(key, jsonEncode(value)));
      } else {
        // Send other values as strings
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });

    final requestHeader = <String, String>{...?(header)};
    requestHeader['Content-Type'] = "multipart/form-data";

    return _request(url, method, body: formData, header: requestHeader);
  }

  /// ========== [ MULTIPART WITH MULTIPLE FILES ] ========== ///
  static Future<ApiResponseModel> multipartMultiple(
    String url, {
    Map<String, String>? header,
    Map<String, String> body = const {},
    String method = "POST",
    String imageName = 'images',
    List<String> imagePaths = const [],
  }) async {
    FormData formData = FormData();

    // Add multiple files with the same field name
    for (String imagePath in imagePaths) {
      if (imagePath.isNotEmpty) {
        final file = File(imagePath);
        final extension = file.path.split('.').last.toLowerCase();
        final originalName = file.uri.pathSegments.isNotEmpty
            ? file.uri.pathSegments.last
            : "image_${DateTime.now().millisecondsSinceEpoch}.$extension";
        final mimeType = lookupMimeType(imagePath);

        formData.files.add(
          MapEntry(
            imageName,
            await MultipartFile.fromFile(
              imagePath,
              filename: originalName,
              contentType: mimeType != null
                  ? DioMediaType.parse(mimeType)
                  : DioMediaType.parse("image/jpeg"),
            ),
          ),
        );
      }
    }

    // Add text fields - explicitly convert to string to avoid type coercion
    body.forEach((key, value) {
      // Ensure all values are sent as plain strings, not parsed by Dio
      formData.fields.add(MapEntry(key, value.toString()));
    });

    final requestHeader = <String, String>{...?(header)};
    requestHeader['Content-Type'] = "multipart/form-data";

    return _request(url, method, body: formData, header: requestHeader);
  }

  /// ========== [ API REQUEST HANDLER ] ========== ///
  static Future<ApiResponseModel> _request(
    String url,
    String method, {
    dynamic body,
    Map<String, String>? header,
  }) async {
    // Frontend-only mode: avoid any network traffic and return a benign response
    // if (AppConfig.frontendOnly) {
    //   return ApiResponseModel(200, {"message": "frontendOnly: no network call", "url": url});
    // }
    try {
      final response = await _dio.request(
        url,
        data: body,
        options: Options(method: method, headers: header),
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static ApiResponseModel _handleResponse(Response response) {
    if (response.statusCode == 201) {
      return ApiResponseModel(200, response.data);
    }
    return ApiResponseModel(response.statusCode, response.data);
  }

  static ApiResponseModel _handleError(dynamic error) {
    try {
      return _handleDioException(error);
    } catch (e) {
      return ApiResponseModel(500, {});
    }
  }

  static ApiResponseModel _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiResponseModel(408, {"message": AppString.requestTimeOut});

      case DioExceptionType.badResponse:
        return ApiResponseModel(error.response?.statusCode, error.response?.data);

      case DioExceptionType.connectionError:
        return ApiResponseModel(503, {"message": AppString.noInternetConnection});

      default:
        return ApiResponseModel(400, {});
    }
  }
}

/// ========== [ DIO INSTANCE WITH INTERCEPTORS ] ========== ///
Dio _getMyDio() {
  Dio dio = Dio();

  dio.interceptors.add(apiLog());

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options
          ..headers["Authorization"] ??= "Bearer ${LocalStorage.token}"
          ..headers["Content-Type"] ??= "application/json"
          ..connectTimeout = const Duration(minutes: 5)
          ..sendTimeout = const Duration(minutes: 5)
          ..receiveDataWhenStatusError = true
          ..responseType = ResponseType.json
          ..receiveTimeout = const Duration(minutes: 5)
          ..baseUrl = options.baseUrl.startsWith("http") ? "" : ApiEndPoint.baseUrl;
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (error, handler) {
        handler.next(error);
      },
    ),
  );

  return dio;
}
