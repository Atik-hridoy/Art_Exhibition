import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/constants/app_string.dart';

class BookingItem extends StatelessWidget {
  final String status;
  const BookingItem({super.key, this.status = "Upcoming"});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 12.w),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      width: double.infinity,

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.r),
      ),

      child: Row(
        children: [
          ClipOval(
            child: CommonImage(
              height: 48, // Use ScreenUtil for scaling
              width: 48,
              // Use ScreenUtil for scaling
              imageSrc: AppImages.female,
            ),
          ),

          15.width,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  text: "Zara Taylor",
                ),

                CommonText(
                  fontSize: 12,
                  top: 3,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bodyClr,
                  text: "25 March 25 | 09:30am - 3:00pm",
                ),

                CommonText(
                  color: status == "Upcoming"
                      ? AppColors.primaryColor
                      : status == "Ongoing"
                      ? AppColors.title2
                      : status == "History"
                      ? Colors.green
                      : Colors.red,
                  text: status == "Upcoming"
                      ? "Pending"
                      : status == "Ongoing"
                      ? "Ongoing"
                      : status == "History"
                      ? "Completed"
                      : "Cancelled",
                ),
              ],
            ),
          ),

          CommonText(
            fontSize: 15,
            top: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
            text: "\$60",
          ),

          SizedBox(
            height: 24.h,
            width: 24.w,
            child: PopupMenuButton<String>(
              color: AppColors.white,
              icon: Icon(Icons.more_vert, color: AppColors.textFiledColor),

              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: '',
                    child: Row(
                      children: [
                        Icon(size: 25, Icons.edit, color: AppColors.textFiledColor),
                        5.width,
                        CommonText(text: AppString.editBooking),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Option 2',
                    child: Row(
                      children: [
                        Icon(size: 25, Icons.clear, color: AppColors.red),
                        5.width,
                        CommonText(color: AppColors.red, text: AppString.cancel),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}
