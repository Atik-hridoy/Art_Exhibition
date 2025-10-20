import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/data_model/category_model.dart';
import 'package:tasaned_project/features/data_model/exibition_card_model.dart';
import 'package:tasaned_project/features/data_model/exibition_model.dart';
import 'package:tasaned_project/features/data_model/feature_arts_model.dart';
import 'package:tasaned_project/features/data_model/features_art_card_model.dart';
import 'package:tasaned_project/features/data_model/saved_art_card_model.dart';
import 'package:tasaned_project/features/data_model/saved_exibition_card_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:tasaned_project/utils/enum/enum.dart';

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
    Utils.errorSnackBar('An error with repository', 'Please contact with developer$e');
    return null;
  }
}

Future<List<FeaturesArtCardModel>?> getRecommendedArt({
  int page = 1,
  int limit = 10,
  int minPrice = 0,
  int maxPrice = 5000,
  ArtStatus artStatus = ArtStatus.unique,
  String category = '',
}) async {
  try {
    var response = await ApiService.get(
      '${ApiEndPoint.recommendedArt}?page=$page&limit=$limit&minPrice=$minPrice&maxPrice=$maxPrice&status=${artStatus.value}&category=$category',
    );

    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => FeaturesArtCardModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return responseBody;
    }
    return null;
  } catch (e) {
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

Future<ArtDetails?> getArtDetails({required String artId}) async {
  try {
    var response = await ApiService.get('${ApiEndPoint.featuresArt}/$artId');

    if (response.statusCode == 200) {
      ArtDetails responseBody = ArtDetails.fromJson(response.data['data']);
      return responseBody;
    }
    return null;
  } catch (e) {
    Utils.errorSnackBar(
      'An error with repository',
      'Please contact with developer art details',
    );
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

