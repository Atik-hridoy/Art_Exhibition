import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class MyEventItem extends StatelessWidget {
  final String cover;
  final String title;
  final String date; // e.g. "01"
  final String month; // e.g. "Oct"
  final String venue;
  const MyEventItem({
    super.key,
    required this.cover,
    required this.title,
    required this.date,
    required this.month,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(right: 16.w),
      width: 158.w,
      height: 190.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CommonImage(
              width: 158.w,
              fill: BoxFit.fill,
              height: 112.h,
              imageSrc: ApiEndPoint.imageUrl + cover,
              // AppImages.eventImage,
            ),
          ),
          // Content below image
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date badge
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.yelloFade,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonText(
                            text: date, // "17",
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                          CommonText(
                            text: month, // "Aug",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.titleColor,
                          ),
                        ],
                      ),
                    ),
                    4.width,

                    // Title area wrapped in Expanded to avoid overflow
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: title, // "Colors of the Unseen",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.titleColor,
                            maxLines: 1,
                          ),
                          5.height,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 16.sp,
                                color: AppColors.bodyClr,
                              ),
                              Expanded(
                                child: CommonText(
                                  left: 2,
                                  text: venue, // "Metus Street, CA",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.bodyClr,
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
