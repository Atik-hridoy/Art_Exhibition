import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/data/models/order_item_model.dart';

class OrderHistoryController extends GetxController {
  OrderHistoryController({OrderHistoryRepository? repository})
      : _repository = repository ?? OrderHistoryRepository();

  static OrderHistoryController? instance = Get.put(OrderHistoryController());

  final OrderHistoryRepository _repository;
  final TextEditingController searchController = TextEditingController();

  String comeFromType = '';
  int selectedTab = 0; // 0 = My Purchase, 1 = My Sales

  String? selectedStatusFilter;
  final List<String> statuses = const [
    'Pending',
    'Processing',
    'Confirmed',
    'Received',
    'Expired',
    'Rejected',
    'Canceled',
    'New Offer',
  ];

  bool isLoadingPurchases = true;
  bool isLoadingSales = false;
  String? purchasesError;
  String? salesError;

  List<OrderItemModel> purchases = [];
  List<OrderItemModel> sales = [];

  @override
  void onInit() {
    super.onInit();
    fetchMyPurchases();
  }

  Future<void> fetchMyPurchases() async {
    try {
      isLoadingPurchases = true;
      purchasesError = null;
      update();

      final result = await _repository.getOrderHistory(type: 'purchases');
      purchases = result ?? [];
    } catch (e) {
      purchasesError = e.toString();
    } finally {
      isLoadingPurchases = false;
      update();
    }
  }

  Future<void> fetchMySales() async {
    try {
      isLoadingSales = true;
      salesError = null;
      update();

      final result = await _repository.getMySales();
      sales = result ?? [];
    } catch (e) {
      salesError = e.toString();
    } finally {
      isLoadingSales = false;
      update();
    }
  }

  void changeTab(int index) {
    if (selectedTab == index) return;
    selectedTab = index;
    selectedStatusFilter = null;
    if (index == 1) {
      fetchMySales();
    }
    update();
  }

  List<OrderItemModel> get currentList => selectedTab == 0 ? purchases : sales;

  List<OrderItemModel> get filteredList {
    final list = currentList;
    if (selectedStatusFilter == null || selectedStatusFilter!.isEmpty) {
      return list;
    }
    final filter = selectedStatusFilter!.toLowerCase();
    return list.where((item) => item.status.toLowerCase() == filter).toList();
  }

  void setFilter(String? status) {
    selectedStatusFilter = status;
    update();
  }

  void clearFilter() {
    selectedStatusFilter = null;
    update();
  }

  void comeFrom(String type) {
    comeFromType = type;
    update();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}