import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/data/models/order_item_model.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/screens/my_order_screen.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/screens/resale_art_screen.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    super.key,
    required this.items,
    required this.selectedTab,
  });

  final List<dynamic> items;
  final int selectedTab; // 0 = Purchase, 1 = Sales

  Color _statusColor(String status) {
    switch (status) {
      case 'Received':
      case 'Confirmed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Processing':
        return Colors.amber;
      case 'New Offer':
        return AppColors.primaryColor;
      case 'Canceled':
      case 'Rejected':
      case 'Expired':
        return Colors.red;
      default:
        return AppColors.titleColor;
    }
  }

  OrderItemModel _parseItem(dynamic raw) {
    if (raw is OrderItemModel) return raw;
    if (raw is Map<String, dynamic>) return OrderItemModel.fromJson(raw);
    return const OrderItemModel(
      id: '',
      title: 'Unknown',
      price: '0',
      image: '',
      status: 'Pending',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 64.sp,
                color: AppColors.titleColor.withOpacity(0.3),
              ),
              16.height,
              CommonText(
                text: selectedTab == 0 ? 'No purchases found' : 'No sales found',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.titleColor.withOpacity(0.6),
              ),
              8.height,
              CommonText(
                text: 'Your orders will appear here',
                fontSize: 12,
                color: AppColors.titleColor.withOpacity(0.4),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final OrderItemModel order = _parseItem(items[index]);
        final Color statusColor = _statusColor(order.status);
        final orderMap = order.toJson();
        final id = orderMap['id'] ?? orderMap['_id'] ?? '';
        return InkWell(
          onTap: () {
            if (selectedTab == 0) {
              Get.to(() => MyOrderScreen(orderId: id.toString(), initialOrder: orderMap));
            } else {
              Get.to(() => MyOrderScreen(orderId: id.toString(), initialOrder: orderMap, isSales: true));
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                CommonImage(
                  height: 64.h,
                  width: 86.w,
                  borderRadius: 8.r,
                  fill: BoxFit.cover,
                  imageSrc: order.image.isNotEmpty ? order.image : AppImages.arts,
                ),
                10.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CommonText(
                              textAlign: TextAlign.left,
                              text: order.title,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.titleColor,
                              maxLines: 1,
                            ),
                          ),
                          if (selectedTab == 0 && order.status == 'Received')
                            GestureDetector(
                              onTap: () => Get.to(() => ResaleArtScreen(order: order.toJson())),
                              child: Icon(
                                CupertinoIcons.arrow_2_squarepath,
                                size: 20.sp,
                                color: AppColors.primaryColor,
                              ),
                            ),
                        ],
                      ),
                      6.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            text: "\$${order.price}",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                          CommonText(
                            text: order.status,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: statusColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}