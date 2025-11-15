import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/features/data_model/artist_details_model.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/utils/helpers/image_helper.dart';
import '../../../../../config/route/app_routes.dart';

class ArtistEventSection extends StatelessWidget {
  final List<ArtistEventItem> events;
  const ArtistEventSection({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: const Text('No events available.'),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: GridView.builder(
          itemCount: events.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 16.h,
            mainAxisExtent: 210.h,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Get.toNamed(
                AppRoutes.eventDetailsScreen,
                arguments: {'eventId': events[index].id},
              ),
              child: _EventItem(item: events[index]),
            );
          }),
    );
  }
}

class _EventItem extends StatelessWidget {
  final ArtistEventItem item;
  const _EventItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final imageSrc = item.images.isNotEmpty
        ? ImageHelper.buildImageUrl(item.images.first)
        : AppImages.eventImage;
    final startDate = item.startDate.split('T').first;
    final day = startDate.isNotEmpty ? startDate.split('-').last : '--';
    final month = startDate.isNotEmpty ? startDate.split('-')[1] : '--';

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
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CommonImage(
                  width: 158.w,
                  fill: BoxFit.cover,
                  height: 112.h,
                  imageSrc: imageSrc,
                ),
              ),

              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  padding: EdgeInsets.all(4),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                  child: Icon(size: 16.sp, Icons.favorite_border),
                ),
              ),
            ],
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
                            text: day,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                          CommonText(
                            text: month,
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
                            text: item.title,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.titleColor,
                            maxLines: 1,
                          ),
                          5.height,
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 16.sp,
                                color: AppColors.bodyClr,
                              ),
                              Expanded(
                                child: CommonText(
                                  left: 6,
                                  text: item.venue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.bodyClr,
                                  maxLines: 1,
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
