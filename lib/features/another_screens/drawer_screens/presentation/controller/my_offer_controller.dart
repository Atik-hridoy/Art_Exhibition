import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/data/models/order_item_model.dart';

class MyOfferController extends GetxController {
  final OrderHistoryRepository _repository = OrderHistoryRepository();
  
  bool isLoading = true;
  String? error;
  List<OrderItemModel> offers = [];

  @override
  void onInit() {
    super.onInit();
    fetchMyOffers();
  }

  Future<void> fetchMyOffers() async {
    try {
      isLoading = true;
      error = null;
      update();

      final result = await _repository.getMyOffers();
      offers = result ?? [];
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  void refreshOffers() {
    fetchMyOffers();
  }
}
