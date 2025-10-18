import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/event_item.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/learning_medarials_item.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/controllers/home_controller.dart';
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
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.height,

            FeatureArtSection(controller: controller),

            20.height,

            CategorySection(controller: controller),

            20.height,

            PopularArtist(controller: controller),

            RecomendedArts(controller: controller),

            20.height,

            UpComingExibition(controller: controller),

            20.height,

            UpcomingEvents(controller: controller),

            20.height,

            LearningMaterials(controller: controller),
          ],
        );
      },
    );
  }
}

class LearningMaterials extends StatelessWidget {
  final HomeController controller;
  const LearningMaterials({super.key, required this.controller});

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
  final HomeController controller;
  const UpcomingEvents({super.key, required this.controller});

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
  final HomeController controller;
  const UpComingExibition({super.key, required this.controller});

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
  final HomeController controller;
  const RecomendedArts({super.key, required this.controller});

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

        controller.featureArtIsLoading
            ? CircularProgressIndicator()
            : controller.recommendedArtList?.length == null ||
                  controller.recommendedArtList?.length == 0
            ? SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SvgPicture.asset(AppIcons.noDataFoundIcon),
                    CommonText(text: AppString.noRecommendedArts, color: Colors.grey),
                  ],
                ),
              )
            : SizedBox(
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
                      child: ArtsItem(
                        imageUrl: controller.recommendedArtList?[index].image ?? '',
                        price: controller.recommendedArtList?[index].price as int,
                        title: controller.recommendedArtList?[index].title ?? '',
                        isSaved:
                            controller.recommendedArtList?[index].isOnFavorite ?? false,
                      ),
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
  final HomeController controller;
  const PopularArtist({super.key, required this.controller});

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
  final HomeController controller;
  const CategorySection({super.key, required this.controller});

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

        controller.categoryIsLoading
            ? CircularProgressIndicator()
            : controller.categoryList?.length == null ||
                  controller.categoryList?.length == 0
            ? SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SvgPicture.asset(AppIcons.noDataFoundIcon),
                    CommonText(text: AppString.noCategory, color: Colors.grey),
                  ],
                ),
              )
            : SizedBox(
                height: 130.h,
                child: ListView.separated(
                  padding: EdgeInsets.only(right: 8.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categoryList!.length < 5
                      ? controller.categoryList!.length
                      : 5,
                  itemBuilder: (context, index) {
                    final item = controller.categoryList?[index];
                    return InkWell(
                      onTap: () => Get.toNamed(
                        AppRoutes.featureArtsScreen,
                        arguments: {"title": AppString.featureArts},
                      ),
                      child: CategoryItem(
                        title: item?.title ?? 'N/A',
                        imageSrc: item?.title != null
                            ? ApiEndPoint.imageUrl + (item?.image ?? '')
                            : '',
                      ),
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
  final HomeController controller;
  const FeatureArtSection({super.key, required this.controller});

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

        controller.featureArtIsLoading
            ? CircularProgressIndicator()
            : controller.featureArtList?.length == null ||
                  controller.featureArtList?.length == 0
            ? SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SvgPicture.asset(AppIcons.noDataFoundIcon),
                    CommonText(text: AppString.nofeatureArts, color: Colors.grey),
                  ],
                ),
              )
            : SizedBox(
                height: 182.h,
                child: ListView.separated(
                  padding: EdgeInsets.only(right: 16.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.featureArtList!.length < 5
                      ? controller.featureArtList!.length
                      : 5,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.artDetailsScreen,
                          arguments: {"screenType": "userHome"},
                        );
                      },
                      child: ArtsItem(
                        imageUrl: controller.featureArtList?[index].image ?? '',
                        price: controller.featureArtList?[index].price as int,
                        title: controller.featureArtList?[index].title ?? '',
                        isSaved: controller.featureArtList?[index].isOnFavorite ?? false,
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(width: 16.w),
                ),
              ),
      ],
    );
  }
}
