import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/controller/my_offer_controller.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/offer_list.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class MyOfferScreen extends StatelessWidget {
  const MyOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyOfferController());
    return Scaffold(
      backgroundColor: AppColors.myListBg,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: CommonText(text: AppString.myOffer),
        leading: InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
            onPressed: controller.refreshOffers,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: GetBuilder<MyOfferController>(
        builder: (controller) {
          // Loading state
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          // Error state
          if (controller.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64.sp,
                    color: AppColors.titleColor.withOpacity(0.3),
                  ),
                  16.height,
                  CommonText(
                    text: 'Error loading offers',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor.withOpacity(0.6),
                  ),
                  8.height,
                  CommonText(
                    text: controller.error!,
                    fontSize: 12,
                    color: AppColors.titleColor.withOpacity(0.4),
                  ),
                  16.height,
                  ElevatedButton(
                    onPressed: controller.refreshOffers,
                    child: CommonText(text: 'Retry'),
                  ),
                ],
              ),
            );
          }

          // Empty state
          if (controller.offers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_offer_outlined,
                    size: 64.sp,
                    color: AppColors.titleColor.withOpacity(0.3),
                  ),
                  16.height,
                  CommonText(
                    text: 'No offers found',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor.withOpacity(0.6),
                  ),
                  8.height,
                  CommonText(
                    text: 'Your offer history will appear here',
                    fontSize: 12,
                    color: AppColors.titleColor.withOpacity(0.4),
                  ),
                ],
              ),
            );
          }
          
          // Show offers
          return SingleChildScrollView(
            child: Column(
              children: [
                12.height,
                OfferList(offers: controller.offers),
              ],
            ),
          );
        },
      ),
    );
  }
}
