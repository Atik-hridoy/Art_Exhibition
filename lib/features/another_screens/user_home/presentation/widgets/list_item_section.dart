import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/event_item.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/learning_medarials_item.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/arts_item.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/category_item.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/popular_artist_item.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

import 'exhibition_item.dart';

// Demo categories for the Home category row
const List<Map<String, String>> _homeCategories = [
  {"title": "Abstract", "image": AppImages.category},
  {"title": "Expressionism", "image": AppImages.category},
  {"title": "Surrealism", "image": AppImages.category},
  {"title": "Minimalism", "image": AppImages.category},
];

class ListItemSection extends StatelessWidget {
  const ListItemSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.height,

        FeatureArtSection(),

        20.height,

        CategorySection(),

        20.height,

        PopularArtist(),

        RecomendedArts(),

        20.height,

        UpComingExibition(),

        20.height,

        UpcomingEvents(),

        20.height,

        LearningMaterials(),
      ],
    );
  }
}

class LearningMaterials extends StatelessWidget {
  const LearningMaterials({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              text: AppString.learningMaterials,
            ),

            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.learningMeterials);
              },
              child: CommonText(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyClr,
                text: AppString.seeAll,
              ),
            ),
          ],
        ),

        16.height,

        SizedBox(
          height: 182.h,
          child: ListView.separated(
            padding: EdgeInsets.only(right: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.artDetailsScreen);
                },
                child: LearningMedarialsItem(),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
          ),
        ),
      ],
    );
  }
}

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              text: AppString.upcomingEvents,
            ),

            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.upComingEventScreen);
              },
              child: CommonText(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyClr,
                text: AppString.seeAll,
              ),
            ),
          ],
        ),

        16.height,

        SizedBox(
          height: 200.h,
          child: ListView.separated(
            padding: EdgeInsets.only(right: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.eventDetailsScreen,
                    arguments: {"title": "User Home"},
                  );
                },
                child: EventItem(),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
          ),
        ),
      ],
    );
  }
}

class UpComingExibition extends StatelessWidget {
  const UpComingExibition({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              text: AppString.upcomingExhibition,
            ),

            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.upComingExhibitionScreen);
              },
              child: CommonText(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyClr,
                text: AppString.seeAll,
              ),
            ),
          ],
        ),

        16.height,

        SizedBox(
          height: 200.h,
          child: ListView.separated(
            padding: EdgeInsets.only(right: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.exhibitionDetailsScreen,
                    arguments: {"title": "User Home"},
                  );
                },
                child: ExhibitionItem(),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
          ),
        ),
      ],
    );
  }
}

class RecomendedArts extends StatelessWidget {
  const RecomendedArts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              text: AppString.recommendedArts,
            ),
          ],
        ),

        16.height,

        SizedBox(
          height: 182.h,
          child: ListView.separated(
            padding: EdgeInsets.only(right: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.artDetailsScreen,
                    arguments: {"screenType": "userHome"},
                  );
                },
                child: ArtsItem(),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
          ),
        ),
      ],
    );
  }
}

class PopularArtist extends StatelessWidget {
  const PopularArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              text: AppString.popularArtist,
            ),

            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.popularArtistScreen);
              },
              child: CommonText(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyClr,
                text: AppString.seeAll,
              ),
            ),
          ],
        ),

        16.height,

        SizedBox(
          height: 120.h,
          child: ListView.separated(
            padding: EdgeInsets.only(right: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.artistDetailsScreen);
                },
                child: PopularArtistItem(),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
          ),
        ),
      ],
    );
  }
}

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              text: AppString.category,
            ),

            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.categoryScreen);
              },
              child: CommonText(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyClr,
                text: AppString.seeAll,
              ),
            ),
          ],
        ),

        16.height,

        SizedBox(
          height: 130.h,
          child: ListView.separated(
            padding: EdgeInsets.only(right: 8.w),
            scrollDirection: Axis.horizontal,
            itemCount: _homeCategories.length,
            itemBuilder: (context, index) {
              final item = _homeCategories[index];
              return InkWell(
                onTap: () => Get.toNamed(
                  AppRoutes.featureArtsScreen,
                  arguments: {"title": AppString.featureArts},
                ),
                child: CategoryItem(title: item['title']!, imageSrc: item['image']!),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: 6.w),
          ),
        ),
      ],
    );
  }
}

class FeatureArtSection extends StatelessWidget {
  const FeatureArtSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              text: AppString.featureArts,
            ),

            InkWell(
              onTap: () {
                Get.toNamed(
                  AppRoutes.featureArtsScreen,
                  arguments: {"title": AppString.featureArts},
                );
              },
              child: CommonText(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyClr,
                text: AppString.seeAll,
              ),
            ),
          ],
        ),

        16.height,

        SizedBox(
          height: 182.h,
          child: ListView.separated(
            padding: EdgeInsets.only(right: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.artDetailsScreen,
                    arguments: {"screenType": "userHome"},
                  );
                },
                child: ArtsItem(),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
          ),
        ),
      ],
    );
  }
}
