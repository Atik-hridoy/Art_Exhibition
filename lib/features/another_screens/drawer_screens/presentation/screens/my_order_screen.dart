import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/order_image_carousel.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/controller/my_order_controller.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/order_info_table.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/my_information_card.dart';
import '../../../../../config/route/app_routes.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key, required this.orderId, this.initialOrder, this.isSales = false});

  final String orderId;
  final Map<String, dynamic>? initialOrder;
  final bool isSales;

  String _formatOrderId(String? orderId) {
    if (orderId == null || orderId.isEmpty) return '--';
    if (orderId.length <= 8) return orderId;
    return orderId.substring(orderId.length - 8);
  }

  String _formatOrderDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '--';
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat('MMM d, yyyy').format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }

  Map<String, dynamic>? _mergeData(MyOrderController controller) {
    final details = controller.orderDetails;
    if (details == null) return initialOrder;
    if (initialOrder == null) return details;
    return {...initialOrder!, ...details};
  }

  @override
  Widget build(BuildContext context) {
    final myOrderCtrl = Get.put(MyOrderController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final status = (initialOrder?['status'] ?? '').toString();
      if (status.isNotEmpty) {
        myOrderCtrl.setInitialStatus(status);
      }
      myOrderCtrl.loadOrderDetails(orderId);
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shadowColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        centerTitle: true,
        title: CommonText(
          text: isSales ? AppString.orderDetails : AppString.myOrder,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 20.sp, color: AppColors.titleColor),
        ),
        actions: [
          if (isSales)
            GetBuilder<MyOrderController>(builder: (c) {
              return PopupMenuButton<String>(
                icon: Icon(Icons.more_horiz, color: AppColors.titleColor, size: 22.sp),
                onSelected: (val) => c.updateStatus(val),
                itemBuilder: (_) => c.statuses
                    .map((s) => PopupMenuItem<String>(
                          value: s,
                          child: Text(s),
                        ))
                    .toList(),
              );
            }),
        ],
      ),
      body: GetBuilder<MyOrderController>(
        builder: (controller) {
          if (controller.isLoading && controller.orderDetails == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null && controller.orderDetails == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonText(
                    text: controller.errorMessage!,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                  ),
                  12.height,
                  ElevatedButton(
                    onPressed: () => controller.loadOrderDetails(orderId),
                    child: const CommonText(
                      text: 'Retry',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            );
          }

          final data = _mergeData(controller);
          final art = data?['artId'] as Map<String, dynamic>?;
          final title = (art?['title'] ?? data?['title'] ?? '').toString();
          final price = (data?['price'] ?? art?['price'] ?? 0).toString();
          final images = <String>[
            if ((data?['artImage'] ?? '').toString().isNotEmpty) data!['artImage'],
            if ((art?['image'] ?? '').toString().isNotEmpty) art!['image'],
          ];

          final shipping = data?['shippingAddress'] as Map<String, dynamic>?;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: OrderImageCarousel(
                      images: images.isNotEmpty
                          ? images
                          : const [
                              AppImages.arts,
                              AppImages.exhibition,
                              AppImages.classic,
                            ],
                      height: 300.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: title.isNotEmpty ? title : 'Untitled Art',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.titleColor,
                        ),
                        5.height,
                        CommonText(
                          text: AppString.abstractLabel,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.titleColorSecondary,
                        ),
                        8.height,
                        CommonText(
                          text: '\$$price',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  20.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CommonText(
                      text: AppString.orderDetails,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleColor,
                    ),
                  ),
                  8.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: InfoTable(rows: [
                      RowItem(AppString.orderId, _formatOrderId(data?['_id']?.toString())),
                      RowItem(AppString.orderDate, _formatOrderDate(data?['createdAt']?.toString())),
                      RowItem(AppString.orderStatus, controller.currentStatus),
                      RowItem(AppString.paymentMethod, data?['paymentMethod']?.toString() ?? '--'),
                      RowItem(AppString.paymentStatus, data?['isPaid'] == true ? 'Paid' : 'Unpaid'),
                      RowItem(AppString.totalAmount, '\$${data?['totalPrice'] ?? price}'),
                    ]),
                  ),
                  24.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CommonText(
                      text: AppString.myInformation,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleColor,
                    ),
                  ),
                  8.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: MyInformationCard(
                      name: shipping?['name']?.toString(),
                      phone: shipping?['phone']?.toString(),
                      address: shipping?['address']?.toString(),
                    ),
                  ),
                  24.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CommonText(
                      text: AppString.additionalInformation,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleColor,
                    ),
                  ),
                  8.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: AppColors.primaryColor, width: 3)),
                        color: AppColors.yelloFade,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: CommonText(
                        text: data?['additionalNote']?.toString().isNotEmpty == true
                            ? data!['additionalNote']
                            : AppString.callMeBeforeSending,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.titleColor,
                      ),
                    ),
                  ),
                  20.height,
                  if (!isSales) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CommonButton(
                        buttonColor: AppColors.transparent,
                        titleText: AppString.viewProductDetails,
                        buttonRadius: 60,
                        titleColor: AppColors.primaryColor,
                        onTap: () {
                          final artId = (data?['artId']?['_id'] ?? data?['artId'] ?? '').toString();
                          if (artId.isNotEmpty) {
                            Get.toNamed(
                              AppRoutes.artDetailsScreen,
                              arguments: {
                                "screenType": "orderDetails",
                                "artId": artId,
                              },
                            );
                          }
                        },
                      ),
                    ),
                    20.height,
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}