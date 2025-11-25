import 'dart:developer';
import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/exibition_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ExhibitionDetailsController extends GetxController {
  bool upComingExibitionIsLoading = false;
  bool isSaved = false;
  Exhibition? exibition;
  String? exibitionId;

  void exibitionDetails() async {
    try {
      upComingExibitionIsLoading = true;
      update();
      
      // Get exhibition ID from arguments
      final args = Get.arguments as Map<String, dynamic>?;
      log('Received arguments: $args');
      final String? exhibitionId = args?['exhibitionId'];
      log('Extracted exhibition ID: $exhibitionId');
      
      if (exhibitionId == null || exhibitionId.isEmpty) {
        log('No exhibition ID provided');
        upComingExibitionIsLoading = false;
        update();
        return;
      }
      
      log('Fetching exhibition details for ID: $exhibitionId');
      
      var response = await getExhibitionDetails(exhibitionId: exhibitionId);
      if (response != null && response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        exibition = Exhibition.fromJson(data);
        exibitionId = exibition!.id;
        isSaved = exibition!.isOnFavorite ?? false;
        log('Exhibition details loaded: ${exibition!.title}');
      } else {
        log('Failed to load exhibition details: ${response?.statusCode}');
      }
      
      upComingExibitionIsLoading = false;
      update();
    } catch (error) {
      upComingExibitionIsLoading = false;
      log('Error loading exhibition details: $error');
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  Future<void> saveToggle() async {
    try {
      if (exibitionId == null) return;
      
      Map<String, dynamic> body = {'type': 'Exhibition', "item": exibitionId};
      var response = await ApiService.post(ApiEndPoint.saveToggle, body: body);
      if (response.statusCode == 200) {
        isSaved = response.data["data"]["deletedCount"] == null;
        update();
      }
    } catch (e) {
      Utils.errorSnackBar('An error with saving', 'Please contact with developer');
      update();
    }
  }

  Future<void> openInBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } catch (e) {
      Utils.errorSnackBar('Error', "Can't open the URL in your device");
    }
  }

  @override
  void onInit() {
    exibitionDetails();
    super.onInit();
  }
}
