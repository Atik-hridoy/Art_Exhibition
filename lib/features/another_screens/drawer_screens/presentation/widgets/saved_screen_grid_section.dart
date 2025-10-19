import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/controller/saved_controller.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/event_item.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/learning_medarials_item.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/enum/enum.dart';

import '../../../../../config/route/app_routes.dart';
import '../../../user_home/presentation/widgets/arts_item.dart';
import '../../../user_home/presentation/widgets/exhibition_item.dart';

class SavedScreenGridSection extends StatelessWidget {
  const SavedScreenGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SavedController(),
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              controller.isSelected == SaveType.arts.value
                  ? SavedArt(controller: controller)
                  : controller.isSelected == SaveType.exhibition.value
                  ? SavedExibition(controller: controller)
                  : controller.isSelected == SaveType.event.value
                  ? SavedEvent()
                  : SavedLearning(),
            ],
          ),
        );
      },
    );
  }
}

class SavedLearning extends StatelessWidget {
  const SavedLearning({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 20,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 15, // Horizontal space between items
        mainAxisSpacing: 20,

        mainAxisExtent: 175.h,
        // Vertical space between items
      ),
      itemBuilder: (context, index) {
        return LearningMedarialsItem();
      },
    );
  }
}

class SavedEvent extends StatelessWidget {
  const SavedEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 20,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 15, // Horizontal space between items
        mainAxisSpacing: 20,

        mainAxisExtent: 185.h,
        // Vertical space between items
      ),
      itemBuilder: (context, index) {
        return EventItem();
      },
    );
  }
}

class SavedExibition extends StatelessWidget {
  final SavedController controller;
  const SavedExibition({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller.upComingExibitionIsLoading
        ? CircularProgressIndicator()
        : controller.savedExibitionList?.length == null ||
              controller.savedExibitionList?.length == 0
        ? SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SvgPicture.asset(AppIcons.noDataFoundIcon),
                CommonText(text: AppString.nofeatureArts, color: Colors.grey),
              ],
            ),
          )
        : GridView.builder(
            itemCount: controller.savedExibitionList?.length ?? 0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 15, // Horizontal space between items
              mainAxisSpacing: 20,

              mainAxisExtent: 200.h,
              // Vertical space between items
            ),
            itemBuilder: (context, index) {
              return ExhibitionItem(
                image: controller.savedExibitionList?[index].image ?? '',
                title: controller.savedExibitionList?[index].title ?? 'N/A',
                venue: controller.savedExibitionList?[index].venue ?? 'N/A',
                isSaved: controller.savedExibitionList?[index].isOnFavorite ?? false,
                startDate:
                    controller.savedExibitionList?[index].startDate ?? DateTime.now(),
                endDate:
                    controller.savedExibitionList?[index].startDate ?? DateTime.now(),
              );
            },
          );
  }
}

class SavedArt extends StatelessWidget {
  final SavedController controller;
  const SavedArt({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller.savedArtIsLoading
        ? CircularProgressIndicator()
        : controller.savedArtList?.length == null || controller.savedArtList?.length == 0
        ? SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SvgPicture.asset(AppIcons.noDataFoundIcon),
                CommonText(text: AppString.noSavedArts, color: Colors.grey),
              ],
            ),
          )
        : GridView.builder(
            itemCount: controller.savedArtList?.length ?? 0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 20,
              mainAxisExtent: 180.h,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.artDetailsScreen,
                    arguments: {'screenType': 'null'},
                  );
                },
                child: ArtsItem(
                  imageUrl: controller.savedArtList?[index].image ?? '',
                  price: controller.savedArtList![index].price as int,
                  title: controller.savedArtList?[index].title ?? '',
                  isSaved: controller.savedArtList?[index].isOnFavorite ?? false,
                  onTapSave: () async {
                    await controller.savedArtToggle(index: index);
                  },
                ),
              );
            },
          );
  }
}
