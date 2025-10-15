import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/data_model/features_art_card_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';

Future<List<FeaturesArtCardModel>?> getFeaturedArt({int page = 1, int limit = 10}) async {
  try {
    var response = await ApiService.get(
      '${ApiEndPoint.featuresArt}?page=$page&limit=$limit',
    );

    if (response.statusCode == 200) {
      var responseBody = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => FeaturesArtCardModel.fromJson(e as Map<String, dynamic>))
          .toList();
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

