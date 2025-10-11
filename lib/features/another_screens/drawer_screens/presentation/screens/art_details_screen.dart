import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/order_image_carousel.dart';

class ArtDetailsScreen extends StatelessWidget {
  const ArtDetailsScreen({super.key, required this.title, required this.price});
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shadowColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        centerTitle: true,
        title: const CommonText(
          text: AppString.artDetails,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 20.sp, color: AppColors.titleColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image carousel
            Padding(
              padding: EdgeInsets.all(16.w),
              child: OrderImageCarousel(
                images: const [AppImages.arts, AppImages.exhibition, AppImages.classic],
                height: 300.h,
              ),
            ),

            // Title, subtitle, price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                  ),
                  4.height,
                  CommonText(
                    text: AppString.abstractLabel,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.titleColorSecondary,
                  ),
                  8.height,
                  CommonText(
                    text: '\$${price}',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),

            16.height,

            // Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const CommonText(
                text: 'Description',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
              ),
            ),
            8.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const CommonText(
                textAlign: TextAlign.start,
                text: AppString.artDetailsDesc,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.titleColor,
                maxLines: 4,
              ),
            ),

            12.height,
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            ).paddingSymmetric(horizontal: 16.w),
            12.height,

            // Specs (bold label, normal value)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: AppString.dimensionsLabel + ' ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.titleColor,
                          ),
                        ),
                        TextSpan(
                          text: AppString.dimensionsValue,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.titleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  6.height,
                  RichText(
                    textAlign: TextAlign.start,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: AppString.authenticationLabel + ' ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.titleColor,
                          ),
                        ),
                        TextSpan(
                          text: AppString.authenticationValue,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.titleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            16.height,
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            ).paddingSymmetric(horizontal: 16.w),
            16.height,

            // About Artist
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const CommonText(
                text: AppString.aboutArtist,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
              ),
            ),
            8.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: AppColors.normalGray,
                    backgroundImage: const AssetImage(AppImages.manBg),
                  ),
                  10.width,
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: AppString.artistNameSample,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.titleColor,
                        ),
                        CommonText(
                          text: 'ARTIST',
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.titleColorSecondary,
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      side: BorderSide(color: AppColors.stroke),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      foregroundColor: AppColors.titleColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person_add_alt,
                          size: 18.sp,
                          color: AppColors.titleColor,
                        ),
                        SizedBox(width: 6),
                        CommonText(
                          text: AppString.follow,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.titleColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            8.height,
            // About section description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CommonText(
                textAlign: TextAlign.start,
                text: AppString.aboutArtistDesc,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.titleColor,
                maxLines: 4,
              ),
            ),

            16.height,
            // Related arts (simple placeholders)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const CommonText(
                text: AppString.relatedArts,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
              ),
            ),
            8.height,
            SizedBox(
              height: 120.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, __) => 12.width,
                itemBuilder: (_, i) {
                  return Container(
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.stroke),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10.r),
                            ),
                            child: CommonImage(
                              height: 140,
                              fill: BoxFit.cover,
                              width: 167,
                              imageSrc: AppImages.artistCover,
                            ),
                          ),
                        ),
                        4.height,
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: CommonText(
                            text: AppString.relatedArtTitleSample,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.titleColor,
                            maxLines: 1,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 6),
                          child: CommonText(
                            text: AppString.relatedArtPriceSample,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),

                        7.height,
                      ],
                    ),
                  );
                },
              ),
            ),
            20.height,
          ],
        ),
      ),
    );
  }
}
