import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/data/models/order_item_model.dart';
import 'package:tasaned_project/config/route/app_routes.dart';

class OfferList extends StatelessWidget {
  const OfferList({
    super.key,
    required this.offers,
  });

  final List<OrderItemModel> offers;

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.amber;
      case 'confirmed':
        return Colors.green;
      case 'rejected':
      case 'canceled':
      case 'expired':
        return Colors.red;
      default:
        return AppColors.titleColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (offers.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Center(
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
        ),
      );
    }

    return ListView.builder(
      itemCount: offers.length,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // Check if index is valid
        if (index >= offers.length) {
          return SizedBox.shrink();
        }
        
        final OrderItemModel offer = offers[index];
        if (offer.id.isEmpty) {
          return SizedBox.shrink();
        }
        
        final Color statusColor = _statusColor(offer.status);
        final offerMap = offer.toJson();
        final id = offerMap['id'] ?? offerMap['_id'] ?? '';
        
        return InkWell(
          onTap: () {
            // Navigate to offer details screen
            Get.toNamed(AppRoutes.offerDetailsScreen, arguments: id.toString());
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Offer Image
                Container(
                  height: 64.h,
                  width: 86.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.background,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: CommonImage(
                      imageSrc: offer.image.isNotEmpty ? offer.image : AppImages.arts,
                      fill: BoxFit.cover,
                    ),
                  ),
                ),
                10.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Offer Title
                      CommonText(
                        textAlign: TextAlign.left,
                        text: offer.title,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      6.height,
                      
                      // Price and Status Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Offer Price
                          CommonText(
                            text: "\$${offer.price}",
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                          
                          // Status Badge
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: statusColor.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: CommonText(
                              text: offer.status,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                      
                      4.height,
                      
                      // Offer ID
                      CommonText(
                        text: "ID: ${id.substring(0, 8)}...",
                        fontSize: 10,
                        color: AppColors.titleColor.withOpacity(0.5),
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
