import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/screens/my_order_screen.dart';

class VisitorOrderList extends StatelessWidget {
  const VisitorOrderList({
    super.key,
    required this.items,
  
  });

  final List<Map<String, dynamic>> items;


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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = items[index];
        final Color statusColor = _statusColor(item['status']);
        final id = (item['id'] ?? item['_id'] ?? '').toString();
            return InkWell(
              onTap: () {
                Get.to(() => MyOrderScreen(orderId: id, initialOrder: item));
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
                  imageSrc: AppImages.arts,
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
                              text: item['title'],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.titleColor,
                              maxLines: 1,
                            ),
                          ),
                     
                        ],
                      ),
                      6.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            text: "\$${item["price"]}",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                          CommonText(
                            text: item['status'],
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
