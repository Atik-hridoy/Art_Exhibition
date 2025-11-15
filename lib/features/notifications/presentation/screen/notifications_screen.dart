import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controller/notifications_controller.dart';
import '../../../../config/api/api_end_point.dart';
import '../widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      
      /// App Bar Section
      appBar: _buildAppBar(),

      /// Body Section
      body: GetBuilder<NotificationsController>(
        builder: (controller) => _buildNotificationsList(controller),
      ),
    );
  }

  /// Build clean app bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.transparent,
      shadowColor: AppColors.transparent,
      elevation: 0,
      leading: _buildBackButton(),
      centerTitle: true,
      title: _buildTitle(),
    );
  }

  /// Build back button
  Widget _buildBackButton() {
    return InkWell(
      onTap: () => Get.back(),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        margin: EdgeInsets.all(8.r),
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColors.titleColor,
          size: 20.sp,
        ),
      ),
    );
  }

  /// Build app bar title
  Widget _buildTitle() {
    return CommonText(
      text: "Notifications",
      color: AppColors.titleColor,
      fontWeight: FontWeight.w600,
      fontSize: 18.sp,
    );
  }

  /// Build notifications list
  Widget _buildNotificationsList(NotificationsController controller) {
    if (controller.isLoading) {
      return _buildLoadingState();
    }

    if (controller.notifications.isEmpty) {
      return _buildEmptyState();
    }

    return _buildNotificationsListView(controller);
  }

  /// Build loading state
  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  /// Build empty state
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64.sp,
            color: AppColors.titleColor.withOpacity(0.3),
          ),
          SizedBox(height: 16.h),
          CommonText(
            text: "No notifications yet",
            fontSize: 16.sp,
            color: AppColors.titleColor.withOpacity(0.6),
          ),
          SizedBox(height: 8.h),
          CommonText(
            text: "You'll see notifications here when you get them",
            fontSize: 14.sp,
            color: AppColors.titleColor.withOpacity(0.4),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build notifications list view
  Widget _buildNotificationsListView(NotificationsController controller) {
    return ListView.builder(
      controller: controller.scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      itemCount: controller.isLoadingMore
          ? controller.notifications.length + 1
          : controller.notifications.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        // Show loading indicator for more data
        if (index >= controller.notifications.length) {
          return _buildLoadMoreIndicator();
        }

        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: NotificationItem(),
        );
      },
    );
  }

  /// Build load more indicator
  Widget _buildLoadMoreIndicator() {
    return Container(
      padding: EdgeInsets.all(16.r),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
