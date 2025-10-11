import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/controller/order_history_controller.dart';
import 'package:tasaned_project/services/storage/storage_services.dart';
import 'package:tasaned_project/utils/enum/enum.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_images.dart';
import '../text/common_text.dart';
import '../image/common_image.dart';

class CommonBottomNavBar extends StatefulWidget {
  final int currentIndex;

  const CommonBottomNavBar({required this.currentIndex, super.key});

  @override
  State<CommonBottomNavBar> createState() => _CommonBottomNavBarState();
}

class _CommonBottomNavBarState extends State<CommonBottomNavBar> {
  final List<String> routes = [
    AppRoutes.userHomeScreen,
    LocalStorage.myRoll == Role.collector.role
        ? AppRoutes.myCollectionsScreen
        : LocalStorage.myRoll == Role.user.role
        ? AppRoutes.visitorOrderHistoryScreen
        : AppRoutes.purchaseHistory,
    AppRoutes.chat,
    AppRoutes.profile,
  ];

  String getTitle(int index) {
    return [
      "Home",

      LocalStorage.myRoll == Role.artist.role ||
              LocalStorage.myRoll == Role.curator.role ||
              LocalStorage.myRoll == Role.museum.role ||
              LocalStorage.myRoll == Role.educational.role
          ? "Add New"
          : "Order",
      "Inbox",
      "Settings",
    ][index];
  }

  String selectedImageSrc(int index) {
    return [
      AppImages.homeActive,
      LocalStorage.myRoll == Role.artist.role ||
              LocalStorage.myRoll == Role.curator.role ||
              LocalStorage.myRoll == Role.museum.role ||
              LocalStorage.myRoll == Role.educational.role
          ? AppImages.addNewInactive
          : AppImages.orderActive,

      AppImages.messageActive,
      AppImages.settingsActive, // Settings (using profile assets)
    ][index];
  }

  String unselectedImageSrc(int index) {
    return [
      AppImages.homeInactive,
      LocalStorage.myRoll == Role.artist.role ||
              LocalStorage.myRoll == Role.curator.role ||
              LocalStorage.myRoll == Role.museum.role ||
              LocalStorage.myRoll == Role.educational.role
          ? AppImages.addNewInactive
          : AppImages.orderInactive,
      AppImages.messageInactive,
      AppImages.settingsInactive,
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) => buildNavItem(index)),
        ),
      ),
    );
  }

  Widget buildNavItem(int index) {
    bool isSelected = widget.currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 1 &&
            (LocalStorage.myRoll == Role.artist.role ||
                LocalStorage.myRoll == Role.curator.role ||
                LocalStorage.myRoll == Role.museum.role)) {
          _showAddNewSheet();
        } else if (index == 1 && LocalStorage.myRoll == Role.educational.role) {
          Get.toNamed(
            AppRoutes.uploadNewLessonScreen,
            arguments: {"title": "Upload New Lesson"},
          );
        } else {
          if (widget.currentIndex == 1 && LocalStorage.myRoll == Role.user.role) {
            OrderHistoryController.instance!.comeFrom("bottom");
          }

          Get.offAllNamed(routes[index]);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.r),
              color: isSelected ? AppColors.title2 : AppColors.transparent,
            ),
            child: CommonImage(
              height: 24,
              width: 24,
              fill: BoxFit.fill,
              imageSrc: isSelected ? selectedImageSrc(index) : unselectedImageSrc(index),
            ),
          ),
          SizedBox(height: 2.h),
          CommonText(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            text: getTitle(index),
            color: isSelected ? AppColors.title2 : AppColors.titleColor,
          ),
        ],
      ),
    );
  }

  void _showAddNewSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 16.h,
          bottom: 24.h + MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Get.back(),
                child: Container(
                  width: 55.h,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColors.bodyClr,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ).center,
              ),

              SizedBox(height: 16.h),

              if (LocalStorage.myRoll == Role.artist.role) ...[
                _actionTile(
                  iconPath: AppImages.uploadArtwork,
                  label: 'Upload Artwork',
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.createExhibitionScreen);
                  },
                ),
                SizedBox(height: 12.h),
                _actionTile(
                  iconPath: AppImages.newExhibition,
                  label: 'Create New Exhibition',
                  onTap: () {
                    Get.back();
                    Get.toNamed(
                      AppRoutes.createNewExhibitionScreen,

                      arguments: {"title": "Create New Exhibition"},
                    );
                  },
                ),
                SizedBox(height: 12.h),
                _actionTile(
                  iconPath: AppImages.createNewEvent,
                  label: 'Create New Event',
                  onTap: () {
                    Get.back();
                    Get.toNamed(
                      AppRoutes.createNewEventScreen,
                      arguments: {"title": "Create New Event"},
                    );
                  },
                ),
              ] else if (LocalStorage.myRoll == Role.curator.role ||
                  LocalStorage.myRoll == Role.museum.role) ...[
                _actionTile(
                  iconPath: AppImages.newExhibition,
                  label: 'Create New Exhibition',
                  onTap: () {
                    Get.back();
                    Get.toNamed(
                      AppRoutes.createNewExhibitionScreen,

                      arguments: {"title": "Create New Exhibition"},
                    );
                  },
                ),
                SizedBox(height: 12.h),
                _actionTile(
                  iconPath: AppImages.createNewEvent,
                  label: 'Create New Event',
                  onTap: () {
                    Get.back();
                    Get.toNamed(
                      AppRoutes.createNewEventScreen,
                      arguments: {"title": "Create New Event"},
                    );
                  },
                ),
              ] else if (LocalStorage.myRoll == Role.educational.role) ...[
                _actionTile(
                  iconPath: AppImages.createNewEvent,
                  label: 'Upload new Learning Materials',
                  onTap: () {
                    Get.back();
                    // Get.toNamed(
                    //   AppRoutes.createNewEventScreen,
                    //   arguments: {"title": "Create New Event"},
                    // );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _actionTile({
    required String iconPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          //border: Border.all(color: AppColors.stroke),
        ),
        child: Row(
          children: [
            Container(
              height: 32.w,
              width: 32.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CommonImage(
                  height: 18.w,
                  width: 18.w,
                  imageSrc: iconPath,
                  fill: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CommonText(
                fontSize: 14,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w500,
                color: AppColors.titleColor,
                text: label,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
