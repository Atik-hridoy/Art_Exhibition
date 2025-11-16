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
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/home_loading_widgets/categories_loading.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/home_loading_widgets/feature_art_loading.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/home_loading_widgets/popular_artist_loading.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/home_loading_widgets/recommended_art_loading.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/home_loading_widgets/upcoming_events_loading.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/home_loading_widgets/upcoming_exibition_loading.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/popular_artist_item.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_loader.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'exhibition_item.dart';

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
    final materials = controller.learningMaterials ?? [];
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

        AppLoader(
          isLoading: controller.learningMaterialIsLoading,
          loaderChild: SizedBox(
            height: 182.h,
            child: const Center(child: CircularProgressIndicator()),
          ),
          child: materials.isEmpty
              ? SizedBox(
                  height: 50.h,
                  child: Row(
                    children: [
                      CommonText(text: AppString.dataEmpty, color: Colors.grey),
                    ],
                  ),
                )
              : SizedBox(
                  height: 182.h,
                  child: ListView.separated(
                    padding: EdgeInsets.only(right: 16.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: materials.length < 5 ? materials.length : 5,
                    itemBuilder: (context, index) {
                      final item = materials[index];
                      return LearningMedarialsItem(
                        title: item.title,
                        imageUrl: item.image,
                        isSaved: item.isOnFavorite,
                        showDescription: false,
                        onTapSave: () => controller.savedLearningListToggle(index: index),
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.learningMaterialsDetailsScreen,
                            arguments: {'learningId': item.id},
                          );
                        },
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(width: 16.w),
                  ),
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

        AppLoader(
          isLoading: controller.featureArtIsLoading,
          loaderChild: UpcomingEventsLoading(),
          child:
              controller.eventsList?.length == null || controller.eventsList?.length == 0
              ? SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SvgPicture.asset(AppIcons.noDataFoundIcon),
                      CommonText(text: AppString.noEvent, color: Colors.grey),
                    ],
                  ),
                )
              : SizedBox(
                  height: 200.h,
                  child: ListView.separated(
                    padding: EdgeInsets.only(right: 16.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.eventsList!.length < 5
                        ? controller.eventsList!.length
                        : 5,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.eventDetailsScreen,
                            arguments: {"title": "User Home"},
                          );
                        },
                        child: EventItem(
                          cover: controller.eventsList?[index].cover ?? '',
                          title: controller.eventsList?[index].title ?? '',
                          date: controller.eventsList?[index].date ?? '',
                          month: controller.eventsList?[index].month ?? '',
                          venue: controller.eventsList?[index].venue ?? '',
                          isSaved: controller.eventsList?[index].isOnFavorite ?? false,
                          onTapSave: () async {
                            controller.savedEventsListToggle(index: index);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(width: 16.w),
                  ),
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

        AppLoader(
          isLoading: controller.upComingExibitionIsLoading,
          loaderChild: UpcomingExibitionLoading(),
          child:
              controller.exhibitionList?.length == null ||
                  controller.exhibitionList?.length == 0
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
                  height: 200.h,
                  child: ListView.separated(
                    padding: EdgeInsets.only(right: 16.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.exhibitionList!.length < 5
                        ? controller.exhibitionList!.length
                        : 5,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.exhibitionDetailsScreen,
                            arguments: {"title": "User Home"},
                          );
                        },
                        child: ExhibitionItem(
                          image: controller.exhibitionList?[index].image ?? '',
                          title: controller.exhibitionList?[index].title ?? 'N/A',
                          venue: controller.exhibitionList?[index].venue ?? 'N/A',
                          isSaved:
                              controller.exhibitionList?[index].isOnFavorite ?? false,
                          startDate:
                              controller.exhibitionList?[index].startDate ??
                              DateTime.now(),
                          endDate:
                              controller.exhibitionList?[index].startDate ??
                              DateTime.now(),
                          onTapSave: () {
                            controller.savedExibitionListToggle(index: index);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(width: 16.w),
                  ),
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

        AppLoader(
          isLoading: controller.recommendedArtIsLoading,
          loaderChild: RecommendedArtLoading(),
          child:
              controller.recommendedArtList?.length == null ||
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
                    itemCount: controller.recommendedArtList!.length < 5
                        ? controller.recommendedArtList!.length
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
                          imageUrl: controller.recommendedArtList?[index].image ?? '',
                          price: controller.recommendedArtList?[index].price ?? 0,
                          title: controller.recommendedArtList?[index].title ?? '',
                          isSaved:
                              controller.recommendedArtList?[index].isOnFavorite ?? false,
                          onTapSave: () {
                            controller.savedArtListToggle(index: index);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(width: 16.w),
                  ),
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

        AppLoader(
          isLoading: controller.populartArtistIsLoading,
          loaderChild: PopularArtistLoading(),
          child:
              controller.popularArtistList?.length == null ||
                  controller.popularArtistList?.length == 0
              ? SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SvgPicture.asset(AppIcons.noDataFoundIcon),
                      CommonText(text: AppString.noPopularArtist, color: Colors.grey),
                    ],
                  ),
                )
              : SizedBox(
                  height: 120.h,
                  child: ListView.separated(
                    padding: EdgeInsets.only(right: 16.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.popularArtistList!.length < 5
                        ? controller.popularArtistList!.length
                        : 5,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          final artist = controller.popularArtistList?[index];
                          if (artist != null) {
                            Get.toNamed(
                              AppRoutes.artistDetailsScreen,
                              arguments: {'artistId': artist.id},
                            );
                          }
                        },
                        child: PopularArtistItem(
                          name: controller.popularArtistList?[index].name ?? 'N/A',
                          profileImage:
                              controller.popularArtistList?[index].profileImage ?? 'N/A',
                          followers: controller.popularArtistList?[index].followers ?? 0,
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(width: 16.w),
                  ),
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

        AppLoader(
          isLoading: controller.categoryIsLoading,
          loaderChild: CategoriesLoading(),
          child:
              controller.categoryList?.length == null ||
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

        AppLoader(
          isLoading: controller.featureArtIsLoading,
          loaderChild: FeatureArtLoading(),
          child:
              controller.featureArtList?.length == null ||
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
                          isSaved:
                              controller.featureArtList?[index].isOnFavorite ?? false,
                          onTapSave: () async {
                            controller.savedArtListToggle(index: index);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(width: 16.w),
                  ),
                ),
        ),
      ],
    );
  }
}
