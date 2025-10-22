import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/bottom_nav_bar/common_bottom_bar.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/my_listing_screen/presentation/controller/my_list_controller.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/component/pop_up/delete_popup.dart';

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyListController>(
      init: MyListController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () => _openFilterSheet(controller),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.stroke),
                    borderRadius: BorderRadius.circular(26.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        color: AppColors.bodyClr,
                        size: 18.sp,
                      ),
                      CommonText(
                        text: AppString.filter,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyClr,
                      ),
                    ],
                  ),
                ),
              ),
              20.width,
            ],
            centerTitle: true,
            title: const CommonText(
              text: AppString.myListing,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.background,
          body: controller.myArtListIsLoading
              ? CircularProgressIndicator()
              : controller.myArtList == null || controller.myArtList?.length == 0
              ? SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SvgPicture.asset(AppIcons.noDataFoundIcon),
                      CommonText(text: AppString.noListing, color: Colors.grey),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  itemCount: controller.myArtList?.length ?? 0,
                  separatorBuilder: (_, __) => 10.height,
                  itemBuilder: (context, index) {
                    final item = controller.myArtList?[index];
                    // final String status = item['status'];
                    // final bool isSold = status == AppString.sold;
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.artDetailsScreen,
                          arguments: {"screenType": "myListing"},
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.stroke),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: CommonImage(
                                height: 60.h,
                                width: 80.h,
                                fill: BoxFit.cover,
                                imageSrc: ApiEndPoint.imageUrl + item!.image,
                              ),
                            ),
                            16.width,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: item.title, // item['title'],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.titleColor,
                                  ),
                                  4.height,
                                  CommonText(
                                    text: '\$${item.price}', //
                                    // Using static price per requirements
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                PopupMenuButton<String>(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  onSelected: (val) {
                                    if (val == 'edit') {
                                      Get.toNamed(
                                        AppRoutes.editArtWorkScreen,
                                        arguments: controller.myArtList?[index].id ?? '',
                                      );
                                    }
                                    if (val == 'delete') {
                                      DeletePopUp.show(
                                        onConfirm: () => controller.deleteItem(index),
                                      );
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem<String>(
                                      value: 'edit',
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.edit,
                                            size: 18,
                                            color: AppColors.titleColor,
                                          ),
                                          SizedBox(width: 8),
                                          CommonText(text: AppString.edit),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.delete_outline,
                                            size: 18,
                                            color: AppColors.redClr,
                                          ),
                                          SizedBox(width: 8),
                                          CommonText(
                                            text: AppString.delete,
                                            color: AppColors.redClr,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  child: const Icon(
                                    Icons.more_vert,
                                    color: AppColors.titleColor,
                                  ),
                                ),
                                6.height,
                                CommonText(
                                  text: item.sold == true ? 'Sold' : 'Available',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: item.sold == true
                                      ? AppColors.redClr
                                      : Colors.green,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

          bottomNavigationBar: CommonBottomNavBar(currentIndex: 1),
        );
      },
    );
  }
}

void _openFilterSheet(MyListController controller) {
  bool tempSelected = controller.selectedFilter;
  Get.bottomSheet(
    StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 16.h,
            bottom: 24.h + MediaQuery.of(Get.context!).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CommonText(
                        text: AppString.filter,
                        fontSize: 16,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.all(2.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.bodyClr),
                        ),
                        child: Icon(Icons.close, color: AppColors.bodyClr, size: 18.sp),
                      ),
                    ),
                  ],
                ),
                16.height,
                _filterTile(
                  label: AppString.available,
                  selected: tempSelected == true,
                  onTap: () => setState(() => tempSelected = true),
                ),
                12.height,
                _filterTile(
                  label: AppString.sold,
                  selected: tempSelected == false,
                  onTap: () => setState(() => tempSelected = false),
                ),
                20.height,
                CommonButton(
                  titleText: AppString.continues,
                  buttonRadius: 60,
                  onTap: () {
                    controller.applyFilter(tempSelected);
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        );
      },
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

Widget _filterTile({
  required String label,
  required bool selected,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        children: [
          Expanded(
            child: CommonText(
              text: label,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.bodyClr,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? AppColors.primaryColor : AppColors.stroke,
                width: 2,
              ),
            ),
            child: selected
                ? Center(
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    ),
  );
}
