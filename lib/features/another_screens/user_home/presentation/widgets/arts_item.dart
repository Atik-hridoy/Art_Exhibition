import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';

class ArtsItem extends StatelessWidget {
  final double itemWidth;
  final double itemHeight;
  final String imageUrl;
  final num price;
  final String title;
  final bool isSaved;
  final VoidCallback? onTapSave;

  const ArtsItem({
    super.key,
    this.itemWidth = 158,
    this.itemHeight = 210,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.isSaved,
    required this.onTapSave,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight.h,
      width: itemWidth.w,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(width: 0.5, color: AppColors.stroke),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(
              builder: (context) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CommonImage(
                        width: double.infinity,
                        fill: BoxFit.fill,
                        height: 107.h,
                        imageSrc: ApiEndPoint.imageUrl + imageUrl,

                        // AppImages.arts,
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
                );
              },
            ),

            CommonText(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              top: 7,
              left: 6,
              right: 6,
              bottom: 8,
              maxLines: 1,
              text: title, // "Whispers of the Forest",
            ),

            CommonText(
              fontSize: 14,
              color: AppColors.primaryColor,
              left: 6,
              fontWeight: FontWeight.w600,
              text: "\$$price", // "\$250",
            ),
          ],
        ),
      ),
    );
  }
}
