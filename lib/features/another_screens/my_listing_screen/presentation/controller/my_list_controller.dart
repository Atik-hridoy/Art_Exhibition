import 'package:get/get.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/my_list_model.dart';
import 'package:tasaned_project/services/api/api_service.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class MyListController extends GetxController {
  bool myArtListIsLoading = false;
  List<CollectionData>? collectionList;
  List<MyArtListing>? myArtList;

  // Current selected filter
  bool selectedFilter = true; // default to Available

  Future<void> myListing() async {
    try {
      myArtListIsLoading = true;
      var response = await getMyListing();
      if (response != null) {
        collectionList = response;
        myArtList = collectionList?[0].arts.where((e) => e.id == e.id).toList();
        // myArtList = collectionList?[0];
        myArtListIsLoading = false;
      }
      update();
    } catch (error) {
      myArtListIsLoading = false;
      Utils.errorSnackBar('Error', error.toString());
      update();
    }
  }

  // void onEdit(int index) {
  //   final item = items[index];
  //   Get.to(() => ResaleArtScreen(order: item));
  // }

  void deleteItem(int index) async {
    String artId = collectionList?[0].arts[index].id ?? '';
    var reponse = await ApiService.delete('${ApiEndPoint.featuresArt}/$artId');

    if (reponse.statusCode == 200 || reponse.statusCode == 201) {
      var temp = collectionList?[0].arts.where((e) => e.id != artId).toList();
      myArtList = temp;
      update();
    }
  }

  void applyFilter(bool filter) {
    selectedFilter = filter;
    var temp = collectionList?[0].arts.where((e) => e.sold != filter).toList();
    myArtList = temp;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    myListing();
    // applyFilter(selectedFilter);
  }
}
