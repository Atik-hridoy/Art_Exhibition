import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/features/data_model/learning_material_model.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/utils/helpers/image_helper.dart';

class LearningHeadingSection extends StatelessWidget {
  final LearningMaterialModel detail;
  final String currentTab;
  final ValueChanged<String> onTabChange;

  const LearningHeadingSection({
    super.key,
    required this.detail,
    required this.currentTab,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    final bannerPath = detail.displayThumbnail;
    final banner = bannerPath.isNotEmpty
        ? ImageHelper.buildImageUrl(bannerPath)
        : AppImages.learningBanner;
    final totalVideos = detail.lessons.length;

    return Column(
      children: [
        10.height,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CommonImage(
                  width: double.infinity,
                  imageSrc: banner,
                  height: 190.h,
                  fill: BoxFit.cover,
                ),
              ),
              15.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      textAlign: TextAlign.start,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleColor,
                      bottom: 8,
                      text: detail.title,
                    ),
                    Row(
                      children: [
                        CommonText(
                          textAlign: TextAlign.start,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyClr,
                          text: 'Total Videos: $totalVideos',
                        ),
                        16.width,
                        const Icon(Icons.watch_later_outlined, size: 18),
                        CommonText(
                          left: 5,
                          textAlign: TextAlign.start,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyClr,
                          text: detail.lessons.isNotEmpty
                              ? 'Approx. 5 min each'
                              : 'Duration: N/A',
                        ),
                      ],
                    ),
                    13.height,
                  ],
                ),
              ),
            ],
          ),
        ),
        11.height,
        _buildCreatorCard(),
        16.height,
        _buildTabs(),
      ],
    );
  }

  Widget _buildCreatorCard() {
    final creatorName = detail.creator?.name ?? 'Unknown Creator';
    final about = detail.creator?.about.isNotEmpty == true ? detail.creator!.about : '';
    final profileImage = detail.creator?.profileImage ?? '';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          ClipOval(
            child: CommonImage(
              height: 48,
              width: 48,
              fill: BoxFit.cover,
              imageSrc: profileImage.isNotEmpty
                  ? ImageHelper.buildImageUrl(profileImage)
                  : AppImages.instationLogo,
            ),
          ),
          10.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                text: creatorName,
              ),
              if (about.isNotEmpty)
                CommonText(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bodyClr,
                  text: about,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _TabButton(
          label: AppString.overview,
          isActive: currentTab == 'overview',
          onTap: () => onTabChange('overview'),
        ),
        _TabButton(
          label: AppString.lessons,
          isActive: currentTab == 'lessons',
          onTap: () => onTabChange('lessons'),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CommonText(
            color: AppColors.titleColor,
            fontSize: 16,
            bottom: 8,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            text: label,
          ),
          if (isActive)
            Container(
              width: 110.w,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.r),
                  topRight: Radius.circular(6.r),
                ),
              ),
            )
          else
            const SizedBox(height: 5),
        ],
      ),
    );
  }
}
