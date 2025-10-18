import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/category_model.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class CategoryController extends GetxController {
  bool categoryIsLoading = false;
  List<CategoryModel>? categoryList = [];
  Future<void> category() async {
    try {
      categoryIsLoading = true;
      var response = await getCategory();
      if (response != null) {
        categoryList = response;
        categoryIsLoading = false;
      }
      update();
    } catch (error) {
      categoryIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  @override
  void onInit() {
    category();
    super.onInit();
  }
}
