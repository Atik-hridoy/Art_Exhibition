import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class ExhibitionItem extends StatelessWidget {
  final String image;
  final String title;
  final String venue;
  final bool isSaved;
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback? onTapSave;

  const ExhibitionItem({
    super.key,
    required this.image,
    required this.title,
    required this.venue,
    required this.isSaved,
    required this.startDate,
    required this.endDate,
    required this.onTapSave,
  });

  @override
  Widget build(BuildContext context) {
    String dateTimeFormat(DateTime date) {
      String formattedDate = DateFormat('d MMM').format(date);
      return formattedDate;
    }

    String formattedStartDate = dateTimeFormat(startDate);
    String formattedEndDate = dateTimeFormat(endDate);

    return Container(
      //margin: EdgeInsets.only(right: 16.w),
      width: 165.w,
      height: 190.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CommonImage(
                  width: 165.w,
                  fill: BoxFit.fill,
                  height: 112.h,
                  imageSrc: ApiEndPoint.imageUrl + image, // AppImages.exhibition,
                ),
              ),

              Positioned(
                top: 7,
                right: 7,
                child: InkWell(
                  onTap: onTapSave,
                  child: Container(
                    padding: EdgeInsets.all(4),

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                    child: Icon(
                      isSaved ? Icons.favorite : Icons.favorite_border,
                      size: 16.sp,
                      color: isSaved ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),

          CommonText(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            top: 5,
            left: 6,
            right: 6,
            bottom: 8,
            text: title, // "Urban Abstractions",
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                Icon(
                  size: 18.sp,
                  color: AppColors.bodyClr,
                  Icons.account_balance_rounded,
                ),
                Flexible(
                  child: CommonText(
                    left: 4,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.bodyClr,
                    text: venue, //"Classical Masters",
                  ),
                ),
              ],
            ),
          ),
          4.height,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                Icon(size: 18.sp, color: AppColors.bodyClr, Icons.calendar_month),
                CommonText(
                  left: 4,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bodyClr,
                  text: '$formattedStartDate - $formattedEndDate', //"Jul 10 - Nov 20",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
