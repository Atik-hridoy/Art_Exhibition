import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/learning_material_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class LearningMaterialsController extends GetxController {
  final List<LearningMaterialModel> _materials = [];
  List<LearningMaterialModel> filteredMaterials = [];
  bool isLoading = false;

  @override
  void onInit() {
    fetchLearningMaterials();
    super.onInit();
  }

  Future<void> fetchLearningMaterials({int limit = 50}) async {
    try {
      isLoading = true;
      update();
      final response = await getLearningMaterials(limit: limit);
      if (response != null) {
        _materials
          ..clear()
          ..addAll(response);
        filteredMaterials = List<LearningMaterialModel>.from(_materials);
      }
    } catch (error) {
      Utils.errorSnackBar('Error', error.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  void onSearchChanged(String query) {
    final keyword = query.trim().toLowerCase();
    if (keyword.isEmpty) {
      filteredMaterials = List<LearningMaterialModel>.from(_materials);
    } else {
      filteredMaterials = _materials
          .where(
            (item) => item.title.toLowerCase().contains(keyword) ||
                item.description.toLowerCase().contains(keyword),
          )
          .toList();
    }
    update();
  }

  Future<void> toggleFavorite({required int index}) async {
    if (index < 0 || index >= filteredMaterials.length) return;
    final learning = filteredMaterials[index];
    try {
      final body = {'type': 'Learning', 'item': learning.id};
      final response = await ApiService.post(ApiEndPoint.saveToggle, body: body);
      if (response.statusCode == 200) {
        final bool isNowSaved = response.data["data"]["deletedCount"] == null;
        learning.isOnFavorite = isNowSaved;
        update();
      }
    } catch (error) {
      Utils.errorSnackBar('Error', 'Could not toggle favorite');
      update();
    }
  }
}
