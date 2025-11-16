import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/helpers/image_helper.dart';

class LearningMedarialsItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final bool isSaved;
  final VoidCallback? onTap;
  final VoidCallback? onTapSave;
  final bool showDescription;

  const LearningMedarialsItem({
    super.key,
    this.title = '',
    this.description = '',
    this.imageUrl = '',
    this.isSaved = false,
    this.onTap,
    this.onTapSave,
    this.showDescription = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.42;
    final cardHeight = cardWidth * 1.15;
    final imageHeight = cardHeight * 0.62;

    return InkWell(
      onTap: onTap ?? () => Get.toNamed(AppRoutes.learningMaterialsDetailsScreen),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: imageHeight,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CommonImage(
                      width: cardWidth,
                      fill: BoxFit.cover,
                      height: imageHeight,
                      imageSrc: imageUrl.isNotEmpty
                          ? ImageHelper.buildImageUrl(imageUrl)
                          : AppImages.learning,
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
                          size: 16.sp,
                          isSaved ? Icons.favorite : Icons.favorite_border,
                          color: isSaved ? AppColors.primaryColor : AppColors.titleColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: cardHeight * 0.05),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 6),
              child: CommonText(
                  left: 4,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.titleColor,
                  maxLines: 1,
                  text: title.isNotEmpty ? title : "Learning material"),
            ),
            if (showDescription)
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: CommonText(
                    left: 4,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.bodyClr,
                    maxLines: 2,
                    text: description.isNotEmpty ? description : "Details coming soon"),
              ),
          ],
        ),
      ),
    );
  }
}
