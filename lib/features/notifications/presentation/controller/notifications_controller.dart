import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/notification_model.dart';
import '../../repository/notification_repository.dart';

class NotificationsController extends GetxController {
  // State variables
  List<NotificationModel> notifications = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasNoData = false;
  int currentPage = 0;
  
  // UI Controllers
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _initializeScrollListener();
    loadNotifications();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  /// Initialize scroll listener for pagination
  void _initializeScrollListener() {
    scrollController.addListener(() {
      if (_shouldLoadMore()) {
        loadMoreNotifications();
      }
    });
  }

  /// Check if should load more notifications
  bool _shouldLoadMore() {
    return scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore &&
        !hasNoData;
  }

  /// Load initial notifications
  Future<void> loadNotifications() async {
    if (isLoading) return;
    
    try {
      isLoading = true;
      currentPage = 1;
      hasNoData = false;
      update();

      // For now, simulate loading since repository might not be implemented
      await Future.delayed(const Duration(seconds: 1));
      
      // TODO: Uncomment when repository is ready
      // List<NotificationModel> list = await notificationRepository(currentPage);
      List<NotificationModel> list = []; // Temporary empty list
      
      notifications = list;
      hasNoData = list.isEmpty;
      
    } catch (e) {
      // Handle error
      notifications = [];
      hasNoData = true;
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Load more notifications for pagination
  Future<void> loadMoreNotifications() async {
    if (isLoadingMore || hasNoData) return;

    try {
      isLoadingMore = true;
      update();

      currentPage++;
      
      // TODO: Uncomment when repository is ready
      // List<NotificationModel> newNotifications = await notificationRepository(currentPage);
      List<NotificationModel> newNotifications = []; // Temporary empty list

      if (newNotifications.isEmpty) {
        hasNoData = true;
      } else {
        notifications.addAll(newNotifications);
      }

    } catch (e) {
      // Handle error
      currentPage--; // Revert page increment on error
    } finally {
      isLoadingMore = false;
      update();
    }
  }

  /// Refresh notifications
  Future<void> refreshNotifications() async {
    notifications.clear();
    hasNoData = false;
    currentPage = 0;
    await loadNotifications();
  }

  /// Mark notification as read
  void markAsRead(int notificationId) {
    // TODO: Implement mark as read functionality
    // Update local state and call API
    update();
  }

  /// Clear all notifications
  void clearAllNotifications() {
    notifications.clear();
    hasNoData = true;
    update();
  }
}
