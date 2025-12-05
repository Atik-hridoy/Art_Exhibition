import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';

class MyOrderController extends GetxController {
  MyOrderController({OrderHistoryRepository? repository})
      : _repository = repository ?? OrderHistoryRepository();

  final OrderHistoryRepository _repository;
  final PageController pageController = PageController();

  int currentIndex = 0;
  String currentStatus = 'Pending';
  final List<String> statuses = const ['Pending', 'Shipped', 'Delivered', 'Canceled'];

  bool isLoading = false;
  String? errorMessage;
  Map<String, dynamic>? orderDetails;

  void onPageChanged(int index) {
    if (currentIndex != index) {
      currentIndex = index;
      update();
    }
  }

  void setInitialStatus(String status) {
    if (status.isNotEmpty) currentStatus = status;
    update();
  }

  void updateStatus(String status) {
    currentStatus = status;
    update();
  }

  Future<void> loadOrderDetails(String orderId) async {
    if (orderId.isEmpty) return;
    try {
      isLoading = true;
      errorMessage = null;
      update();

      final data = await _repository.getOrderDetails(orderId);
      if (data != null) {
        orderDetails = data;
        currentStatus = (data['status'] ?? currentStatus).toString();
      } else {
        errorMessage = 'Failed to load order details';
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
