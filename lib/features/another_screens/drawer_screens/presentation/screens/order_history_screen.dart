import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/services/storage/storage_services.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/enum/enum.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/order_tabs.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/order_list.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/order_filter_sheet.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import '../controller/order_history_controller.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide controller for AppBar actions and the body
    final controller = Get.put(OrderHistoryController());
    return Scaffold(
      backgroundColor: AppColors.myListBg,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shadowColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        centerTitle: true,
        title: CommonText(
          text: AppString.orderHistory,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 20.sp, color: AppColors.titleColor),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: OutlinedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => OrderFilterSheet(
                    statuses: controller.statuses,
                    initialSelected: controller.selectedStatusFilter,
                    onApply: (value) {
                      Navigator.of(context).pop();
                      controller.setFilter(value);
                    },
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                side: BorderSide(color: AppColors.stroke),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                foregroundColor: AppColors.titleColor,
              ),
              icon: Icon(Icons.filter_alt_outlined, size: 16.sp),
              label: CommonText(
                text: AppString.filter,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.titleColor,
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<OrderHistoryController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tabs
                if (LocalStorage.myRoll != Role.user.role)
                  OrderTabs(
                    selectedTab: controller.selectedTab,
                    onChanged: controller.changeTab,
                  ),

                12.height,
                // Order list
                OrderList(
                  items: controller.filteredList,
                  selectedTab: controller.selectedTab,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
