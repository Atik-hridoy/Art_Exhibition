import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/constants/app_string.dart';

class HistoryItem extends StatelessWidget {
  final String status;
  const HistoryItem({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.nunnyBookingDetailsScreen);
      },
      child: Container(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        text: "Zara Taylor",
                      ),

                      CommonText(
                        fontSize: 16,

                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                        text: "\$60",
                      ),
                    ],
                  ),
                  6.height,

                  Row(
                    children: [
                      Icon(Icons.calendar_month, color: AppColors.bodyClr),
                      5.width,
                      CommonText(
                        fontSize: 12,
                        top: 3,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyClr,
                        text: "25 March 25 | 09:30am - 3:00pm",
                      ),
                    ],
                  ),

                  2.height,

                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: AppColors.bodyClr),
                      5.width,
                      CommonText(
                        fontSize: 12,
                        top: 3,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyClr,
                        text: "123 Ngong Road, Nairobi, Kenya",
                      ),
                    ],
                  ),

                  if (status != "upComing" &&
                      status != "onGoing" &&
                      status != "newRequest")
                    CommonText(color: Colors.green, text: "Completed"),

                  if (status == "newRequest")
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6.h),
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(60.r),
                          ),
                          child: CommonText(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                            text: AppString.accept,
                          ),
                        ),

                        12.width,

                        Container(
                          margin: EdgeInsets.only(top: 6.h),
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(60.r),
                          ),
                          child: CommonText(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                            text: AppString.decline,
                          ),
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
  }
}
