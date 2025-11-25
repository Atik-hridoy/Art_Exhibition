import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/screens/art_details_screen.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key, required this.order, this.isSales = false});

  final Map<String, dynamic> order;
  final bool isSales;

  @override
  Widget build(BuildContext context) {
    // put controller for carousel and status
    final myOrderCtrl = Get.put(MyOrderController());
    final title = (order['title'] ?? '').toString();
    final price = (order['price'] ?? 0).toString();
    //final status = (order['status'] ?? '').toString();

    // ensure initial status is set after first frame to avoid update() during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myOrderCtrl.setInitialStatus((order['status'] ?? '').toString());
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top image/banner as slidable carousel
              Padding(
                padding: EdgeInsets.all(16.w),
                child: OrderImageCarousel(
                  images: const [
                    AppImages.arts,
                    AppImages.exhibition,
                    AppImages.classic,
                  ],
                  height: 300.h,
                ),
              ),

              // Title, subtitle, price
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: title,
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
                      fontSize:24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),

              20.height,

              // Order Details card
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
                child: GetBuilder<MyOrderController>(builder: (c) {
                  return InfoTable(rows: [
                    RowItem(AppString.orderId, '#ORD-2024-0892'),
                    RowItem(AppString.orderDate, 'Aug 19, 2025'),
                    RowItem(AppString.orderStatus, c.currentStatus),
                    RowItem(AppString.paymentMethod, 'Credit Card'),
                    RowItem(AppString.paymentStatus, 'Paid'),
                    RowItem(AppString.totalAmount, '\$$price.00'),
                  ]);
                }),
              ),

              24.height,

              // My Information
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
                child: const MyInformationCard(),
              ),

              24.height,

              // Additional Information
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
                    text: AppString.callMeBeforeSending,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                ),
              ),

              20.height,

              // View product details button (hidden for My Sales)
              if (!isSales) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CommonButton(
                    buttonColor: AppColors.transparent,
                    titleText: AppString.viewProductDetails,
                    buttonRadius: 60,
                    titleColor: AppColors.primaryColor,
                    onTap: () {
                      Get.to(() => ArtDetailsScreen(title: title, price: price));
                    },
                  ),
                ),

                20.height,
              ],
            ],
          ),
        ),
      ),
    );
  }

}