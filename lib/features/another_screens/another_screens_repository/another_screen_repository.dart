import 'dart:developer';
import 'dart:io';

import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/data/models/order_item_model.dart';
import 'package:tasaned_project/features/data_model/artist_card_model.dart';
import 'package:tasaned_project/features/data_model/artist_details_model.dart';
import 'package:tasaned_project/features/data_model/category_model.dart';
import 'package:tasaned_project/features/data_model/event_card_model.dart';
import 'package:tasaned_project/features/data_model/event_model.dart';
import 'package:tasaned_project/features/data_model/exibition_card_model.dart';
import 'package:tasaned_project/features/data_model/exibition_model.dart';
import 'package:tasaned_project/features/data_model/feature_arts_model.dart';
import 'package:tasaned_project/features/data_model/features_art_card_model.dart';
import 'package:tasaned_project/features/data_model/learning_material_model.dart';
import 'package:tasaned_project/features/data_model/my_list_model.dart';
import 'package:tasaned_project/features/data_model/saved_art_card_model.dart';
import 'package:tasaned_project/features/data_model/saved_event_card_model.dart';
import 'package:tasaned_project/features/data_model/saved_exibition_card_model.dart';
import 'package:tasaned_project/features/data_model/saved_learning_card_model.dart';
import 'package:tasaned_project/services/api/api_response_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/services/storage/storage_services.dart';
import 'package:tasaned_project/utils/app_utils.dart';

Future<List<FeaturesArtCardModel>?> getFeaturedArt({
  int page = 1,
  int limit = 10,
  String category = '',
}) async {
  try {
    var response = await ApiService.get(
      '${ApiEndPoint.featuresArt}?page=$page&limit=$limit&category=$category',
    );

    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => FeaturesArtCardModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
    print('Repository error details: $e');
    Utils.errorSnackBar('An error with repository', 'Please contact with developer: $e');
    return null;
  }
}

Future<ApiResponseModel?> addCourse({
  required String title,
  required String overview,
  required String learningObject,
  required String thumbnailPath,
}) async {
  try {
    final response = await ApiService.multipart(
      ApiEndPoint.addCourse,
      body: {
        'title': title,
        'overview': overview,
        'learningObject': learningObject,
      },
      imageName: 'thumbnail',
      imagePath: thumbnailPath,
    );

    log('Add course status => ${response.statusCode}');
    log('Add course data => ${response.data}');

    if (response.statusCode != 200) {
      Utils.errorSnackBar('Failed', response.message);
    }

    return response;
  } catch (e) {
    log('Error adding course: $e');
    Utils.errorSnackBar('An error with repository', 'Please contact with developer$e');
    return null;
  }
}

Future<LearningMaterialModel?> getLearningDetail(String learningId) async {
  try {
    final endpoint = '${ApiEndPoint.getLearningDetails}/$learningId';
    log('Fetching learning detail => $endpoint');
    final response = await ApiService.get(endpoint);
    log('Learning detail status => ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = (response.data['data'] ?? response.data) as Map<String, dynamic>;
      log('Learning detail fetched for id $learningId, title: ${data['title']}');
      return LearningMaterialModel.fromJson(data);
    }

    return null;
  } catch (e) {
    log('Error fetching learning detail: $e');
    Utils.errorSnackBar('An error with repository', 'Please contact with developer $e');
    return null;
  }
}

Future<List<SavedLearningCardModel>?> getSavedLearningItem({
  int page = 1,
  int limit = 10,
}) async {
  try {
    var response = await ApiService.get(
      '${ApiEndPoint.savedItem}?page=$page&limit=$limit&type=Learning',
    );

    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => SavedLearningCardModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer');
    return null;
  }
}

Future<List<LearningMaterialModel>?> getLearningMaterials({
  int page = 1,
  int limit = 10,
}) async {
  try {
    final response = await ApiService.get(
      '${ApiEndPoint.getLearningMatrials}?page=$page&limit=$limit',
    );

    if (response.statusCode == 200) {
      final responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => LearningMaterialModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer$e');
    return null;
  }
}

Future<ArtistDetailsModel?> getArtistDetails(String artistId) async {
  try {
    final response = await ApiService.get('${ApiEndPoint.users}/$artistId');

    if (response.statusCode == 200) {
      return ArtistDetailsModel.fromJson(response.data['data'] as Map<String, dynamic>);
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer$e');
    return null;
  }
}

Future<ApiResponseModel?> followArtist(String artistId) async {
  try {
    final response = await ApiService.post(
      ApiEndPoint.following,
      body: {'followingId': artistId},
    );
    return response;
  } catch (e) {
    Utils.errorSnackBar('Error', 'Failed to follow artist');
    return null;
  }
}

Future<ApiResponseModel?> unfollowArtist(String artistId) async {
  try {
    final response = await ApiService.post(
      ApiEndPoint.unFollowing,
      body: {'followingId': artistId},
    );
    return response;
  } catch (e) {
    Utils.errorSnackBar('Error', 'Failed to unfollow artist');
    return null;
  }
}

Future<List<ArtistCardModel>?> getPopularArtist({
  int page = 1,
  int limit = 10,
  String role = 'ARTIST',
  String status = 'ACTIVE',
  String sort = '-followers',
  String? searchTerm,
}) async {
  try {
    final queryParameters = {
      'role': role,
      'status': status,
      'sort': sort,
      'page': '$page',
      'limit': '$limit',
      if (searchTerm != null && searchTerm.isNotEmpty) 'searchTerm': searchTerm,
    };

    final queryString = Uri(queryParameters: queryParameters).query;
    final url = '${ApiEndPoint.users}?$queryString';

    var response = await ApiService.get(url);

    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => ArtistCardModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer$e');
    return null;
  }
}

Future<List<FeaturesArtCardModel>?> getRecommendedArt({
  int page = 1,
  int limit = 10,
  int minPrice = 0,
  int maxPrice = 5000,
  String artStatus = 'Unique',
  String category = '',
}) async {
  try {
    var response = await ApiService.get(
      '${ApiEndPoint.recommendedArt}?page=$page&limit=$limit&minPrice=$minPrice&maxPrice=$maxPrice&status=$artStatus&category=$category',
    );

    if (response.statusCode == 200) {
      print('=== RECOMMENDED ART RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Data type: ${response.data.runtimeType}');
      print('Data keys: ${response.data.keys}');
      
      final dataList = response.data['data'] as List<dynamic>? ?? [];
      print('Data list length: ${dataList.length}');
      
      var responseBody = dataList
          .map((e) {
            try {
              print('Processing item: ${e.runtimeType}');
              if (e is String) {
                print('Item is String, skipping');
                return null;
              } else if (e is Map<String, dynamic>) {
                print('Item is Map, parsing... ID: ${e['_id']}, Title: ${e['title']}');
                final model = FeaturesArtCardModel.fromJson(e);
                print('Parsed successfully: ${model.title}');
                return model;
              } else {
                print('Item is unknown type: ${e.runtimeType}, skipping');
                return null;
              }
            } catch (parseError) {
              print('Parse error: $parseError');
              return null;
            }
          })
          .where((item) => item != null)
          .cast<FeaturesArtCardModel>()
          .toList();
      
      print('Final list length: ${responseBody.length}');
      print('=== END RECOMMENDED ART ===');
      return responseBody;
    }
    return null;
  } catch (e) {
    print('Error in getRecommendedArt: $e');
    Utils.errorSnackBar('An error with repository', 'Please contact with developer$e');
    return null;
  }
}

Future<List<SavedArtCardModel>?> getSavedArtItem({int page = 1, int limit = 10}) async {
  try {
    var response = await ApiService.get(
      '${ApiEndPoint.savedItem}?page=$page&limit=$limit&type=Arts',
    );

    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => SavedArtCardModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer');
    return null;
  }
}

Future<List<SavedExibitionCardModel>?> getSavedExibitionItem({
  int page = 1,
  int limit = 10,
}) async {
  try {
    var response = await ApiService.get(
      '${ApiEndPoint.savedItem}?page=$page&limit=$limit&type=Exhibition',
    );

    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => SavedExibitionCardModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer');
    return null;
  }
}

Future<List<SavedEventCardModel>?> getSavedEventItem({
  int page = 1,
  int limit = 10,
}) async {
  try {
    var response = await ApiService.get(
      '${ApiEndPoint.savedItem}?page=$page&limit=$limit&type=Event',
    );

    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => SavedEventCardModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer');
    return null;
  }
}

Future<ArtDetails?> getArtDetails({required String artId}) async {
  try {
    var response = await ApiService.get('${ApiEndPoint.featuresArt}/$artId');

    if (response.statusCode == 200) {
      ArtDetails responseBody = ArtDetails.fromJson(response.data['data']);
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer');
    return null;
  }
}

Future<Exhibition?> getExibitionDetails({required String id}) async {
  try {
    var response = await ApiService.get('${ApiEndPoint.exhibition}/$id');

    if (response.statusCode == 200) {
      var responseBody = Exhibition.fromJson(response.data['data']);
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer');
    return null;
  }
}

Future<EventModel?> getEventDetails({required String eventId}) async {
  try {
    final endpoint = '${ApiEndPoint.eventDetails}/$eventId';
    log('Fetching event details => $endpoint');
    final response = await ApiService.get(endpoint);
    log('Event details status => ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = (response.data['data'] ?? response.data) as Map<String, dynamic>;
      log('Event details fetched for id $eventId, title: ${data['title']}');
      return EventModel.fromJson(data);
    }

    return null;
  } catch (e) {
    log('Error fetching event details: $e');
    Utils.errorSnackBar('An error with repository', 'Please contact with developer $e');
    return null;
  }
}

Future<List<CategoryModel>?> getCategory() async {
  try {
    var response = await ApiService.get('${ApiEndPoint.category}?limit=10000');

    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer');
    return null;
  }
}

Future<List<ExhibitionCardModel>?> getExibition({int page = 1, int limit = 10}) async {
  try {
    var response = await ApiService.get(ApiEndPoint.exhibition);

    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => ExhibitionCardModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer');
    return null;
  }
}

Future<List<ExhibitionCardModel>?> getMyExibition({int page = 1, int limit = 10}) async {
  try {
    var response = await ApiService.get('${ApiEndPoint.users}/${LocalStorage.userId}');
    if (response.statusCode == 200) {
      log('My Exibition data fetched');
      log(LocalStorage.userId);
      var responseBody = (response.data['data']["exhibitions"] as List<dynamic>? ?? [])
          .map((e) => ExhibitionCardModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer');
    return null;
  }
}

Future<List<EventModel>?> getMyEvent({int page = 1, int limit = 10}) async {
  try {
    log('Calling API: ${ApiEndPoint.getMyEvents}');
    var response = await ApiService.get(ApiEndPoint.getMyEvents);
    log('API Response Status: ${response.statusCode}');
    log('API Response Data: ${response.data}');
    
    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList();
      log('Parsed ${responseBody.length} events');
      return responseBody;
    }
    log('API returned status ${response.statusCode}, expected 200');
    return null;
  } catch (e) {
    log('Error in getMyEvent repository: $e');
    Utils.errorSnackBar('An error with repository', 'Please contact with developer');
    return null;
  }
}

Future<List<CollectionData>?> getMyListing({int page = 1, int limit = 10}) async {
  try {
    var response = await ApiService.get(ApiEndPoint.myList);
    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => CollectionData.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer');
    return null;
  }
}

Future<List<EventCardModel>?> getEvents({int page = 1, int limit = 10}) async {
  try {
    var response = await ApiService.get(ApiEndPoint.events);

    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => EventCardModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar('An error with repository', 'Please contact with developer');
    return null;
  }
}

Future<ApiResponseModel?> createEventWithImages({
  required Map<String, dynamic> eventData,
  required List<String> imagePaths,
}) async {
  try {
    log('Creating event with ${imagePaths.length} images');
    
    // Filter out invalid image paths
    List<String> validImagePaths = [];
    for (String path in imagePaths) {
      final file = File(path);
      if (file.existsSync()) {
        validImagePaths.add(path);
      } else {
        log('Image file not found: $path');
      }
    }
    
    log('Valid images found: ${validImagePaths.length}');
    
    // Prepare form data
    Map<String, String> body = {};
    eventData.forEach((key, value) {
      if (value != null && value.toString().isNotEmpty && key != 'images') {
        body[key] = value.toString();
      }
    });
    
    // Create event with first valid image if available
    if (validImagePaths.isNotEmpty) {
      final response = await ApiService.multipart(
        ApiEndPoint.eventCreation,
        body: body,
        imagePath: validImagePaths.first,
        imageName: 'images',
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        // If there are more images, upload them separately
        if (validImagePaths.length > 1) {
          final eventId = response.data['data']?['_id'];
          if (eventId != null) {
            for (int i = 1; i < validImagePaths.length; i++) {
              await ApiService.multipart(
                '${ApiEndPoint.eventCreation}/$eventId',
                body: {},
                imagePath: validImagePaths[i],
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
        ApiEndPoint.eventCreation,
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

Future<ApiResponseModel?> getExhibitionDetails({required String exhibitionId}) async {
  try {
    final response = await ApiService.get('${ApiEndPoint.exhibitionDetails}/$exhibitionId');
    
    if (response.statusCode == 200) {
      log('Exhibition details retrieved successfully');
      return response;
    } else {
      log('Failed to get exhibition details: ${response.statusCode}');
      return response;
    }
  } catch (e) {
    log('Error getting exhibition details: $e');
    Utils.errorSnackBar('An error with repository', 'Please contact with developer $e');
    return null;
  }
}

// =========================myOrder============================


class OrderHistoryRepository {
  Future<List<OrderItemModel>?> getOrderHistory({String type = 'purchases'}) async {
    try {
      final endpoint = type.isNotEmpty
          ? '${ApiEndPoint.getMyOrder}?type=$type'
          : ApiEndPoint.getMyOrder;
      final response = await ApiService.get(endpoint);
      
      if (response.statusCode == 200) {
        final dataList = response.data['data'] as List<dynamic>? ?? [];
        
        final List<OrderItemModel> orders = [];
        for (int i = 0; i < dataList.length; i++) {
          try {
            final item = dataList[i];
            final order = OrderItemModel.fromJson(item as Map<String, dynamic>);
            orders.add(order);
          } catch (e) {
            // Continue with other items instead of failing completely
          }
        }
        
        return orders;
      }
      return null;
    } catch (e) {
      Utils.errorSnackBar('Order history', 'Please contact the developer');
      return null;
    }
  }

  Future<List<OrderItemModel>?> getMySales() async {
    try {
      final response = await ApiService.get(ApiEndPoint.getMySales);
      
      if (response.statusCode == 200) {
        final dataList = response.data['data'] as List<dynamic>? ?? [];
        
        final List<OrderItemModel> orders = [];
        for (int i = 0; i < dataList.length; i++) {
          try {
            final item = dataList[i];
            final order = OrderItemModel.fromJson(item as Map<String, dynamic>);
            orders.add(order);
          } catch (e) {
            // Continue with other items instead of failing completely
          }
        }
        
        return orders;
      }
      return null;
    } catch (e) {
      Utils.errorSnackBar('My sales', 'Please contact the developer');
      return null;
    }
  }

  Future<List<OrderItemModel>?> getMyOffers() async {
    try {
      final response = await ApiService.get('offer/my-offer');
      
      if (response.statusCode == 200) {
        final dataList = response.data['data'] as List<dynamic>? ?? [];
        
        final List<OrderItemModel> offers = [];
        for (int i = 0; i < dataList.length; i++) {
          try {
            final item = dataList[i];
            final offer = OrderItemModel.fromJson(item as Map<String, dynamic>);
            offers.add(offer);
          } catch (e) {
            // Continue with other items instead of failing completely
          }
        }
        
        return offers;
      }
      return null;
    } catch (e) {
      Utils.errorSnackBar('My offers', 'Please contact the developer');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getOfferDetails(String offerId) async {
    try {
      if (offerId.isEmpty) return null;
      final response = await ApiService.get('offer/$offerId');
      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data is Map<String, dynamic>) {
          return data;
        }
      }
      return null;
    } catch (e) {
      Utils.errorSnackBar('Offer details', 'Please contact the developer');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getOrderDetails(String orderId) async {
    try {
      if (orderId.isEmpty) return null;
      final response = await ApiService.get('${ApiEndPoint.order}/$orderId');
      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data is Map<String, dynamic>) {
          return data;
        }
      }
      return null;
    } catch (e) {
      Utils.errorSnackBar('Order details', 'Please contact the developer');
      return null;
    }
  }

  /// Create an order from an accepted offer
  Future<ApiResponseModel?> createOrderFromOffer({
    required String artId,
    required double price,
    required String offerId,
    required Map<String, dynamic> shippingAddress,
    String additionalNote = '',
  }) async {
    try {
      // Calculate shipping charge and total price
      const double shippingCharge = 50.0; // Fixed shipping charge
      final double totalPrice = price + shippingCharge;

      // Construct the request body according to API structure
      final Map<String, dynamic> requestBody = {
        "artId": artId,
        "price": price,
        "shippingCharge": shippingCharge,
        "totalPrice": totalPrice,
        "paymentMethod": "card",
        "additionalNote": additionalNote,
        "shippingAddress": shippingAddress,
        "offerId": offerId, // Include offerId to link this order to the offer
      };

      log('Creating order with data: $requestBody');

      final response = await ApiService.post(ApiEndPoint.order, body: requestBody);
      
      log('Order creation status: ${response.statusCode}');
      log('Order creation response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Order created successfully');
        return response;
      } else {
        log('Failed to create order: ${response.statusCode}');
        return response;
      }
    } catch (e) {
      log('Error creating order: $e');
      Utils.errorSnackBar('Order creation', 'Please contact the developer: $e');
      return null;
    }
  }
}



// Future<ArtsResponse?> getFeaturedArt({int page = 1}) async {
//   try {
//     var response = await ApiService.get('${ApiEndPoint.featuresArt}?page=$page');

//     if (response.statusCode == 200) {
//       var responseBody = ArtsResponse.fromJson(response.data as Map<String, dynamic>);
//       return responseBody;
//     }
//     return null;
//   } catch (e) {
//     Utils.errorSnackBar('An error with repository', 'Please contact with developer');
//     return null;
//   }
// }

