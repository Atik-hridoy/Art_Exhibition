import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/controllers/feature_arts_controller.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/arts_item.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class FeatureArtsScreen extends StatelessWidget {
  FeatureArtsScreen({super.key});
  final String title = Get.arguments["title"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        shadowColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        title: CommonText(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
          text: title,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 23.sp, color: AppColors.titleColor),
        ),
      ),

      body: GetBuilder<FeatureArtsController>(
        init: FeatureArtsController(),
        builder: (controller) => Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: _showSortSheet,
                    child: Container(
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: AppColors.searchBg,
                        border: Border(
                          bottom: BorderSide(color: AppColors.stroke),
                          right: BorderSide(color: AppColors.stroke),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(size: 18.sp, color: AppColors.bodyClr, Icons.swap_vert),

                          CommonText(
                            fontSize: 16,
                            left: 3,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bodyClr,
                            text: AppString.sort,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: _showFilterSheet,
                    child: Container(
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: AppColors.searchBg,
                        border: Border(
                          bottom: BorderSide(color: AppColors.stroke),
                          right: BorderSide(color: AppColors.stroke),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            size: 18.sp,
                            color: AppColors.bodyClr,
                            Icons.filter_alt_rounded,
                          ),

                          CommonText(
                            fontSize: 16,
                            left: 3,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bodyClr,
                            text: AppString.filter,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            15.height,

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
                : Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: GridView.builder(
                        itemCount: controller.featureArtList?.length ?? 0,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 16, // Horizontal space between items
                          mainAxisSpacing: 20, // Vertical space between items
                          mainAxisExtent:
                              210, // Tile height to prevent overflow of ArtsItem
                        ),
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
                                await controller.savedToggle(index: index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // ================= Sort Bottom Sheet =================
  void _showSortSheet() {
    Get.bottomSheet(
      GetBuilder<FeatureArtsController>(
        builder: (controller) {
          return _sheetContainer(
            title: 'Short by',
            child: Column(
              children: [
                _sortTile(controller, 0, 'Newest Arrivals'),
                12.height,
                _sortTile(controller, 1, 'Popularity'),
                12.height,
                _sortTile(controller, 2, 'Price'),
                20.height,
                CommonButton(
                  titleText: 'Apply',
                  buttonRadius: 60,
                  onTap: () => Get.back(),
                ),
              ],
            ),
          );
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _sortTile(FeatureArtsController c, int index, String label) {
    final bool selected = c.selectedSort == index;
    return InkWell(
      onTap: () => c.setSort(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Row(
          children: [
            Expanded(
              child: CommonText(
                fontSize: 14,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w500,
                color: AppColors.titleColor,
                text: label,
              ),
            ),
            Container(
              height: 20,
              width: 20,
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

  // ================= Filter Bottom Sheet =================
  void _showFilterSheet() {
    Get.bottomSheet(
      GetBuilder<FeatureArtsController>(
        builder: (controller) {
          return _sheetContainer(
            title: 'Filter',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.height,
                CommonText(
                  text: 'Category',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.titleColor,
                ),

                12.height,
                _categoryDropdown(controller),
                25.height,
                CommonText(
                  text: 'Price',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.titleColor,
                ),
                18.height,
                _priceRange(controller),
                16.height,
                CommonText(
                  text: 'Status',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.titleColor,
                ),
                25.height,
                Row(
                  children: [
                    _statusChip(controller, 'Unique'),
                    12.width,
                    _statusChip(controller, 'Resale'),
                  ],
                ),
                30.height,
                CommonButton(
                  titleText: 'Apply',
                  buttonRadius: 60,
                  onTap: () => Get.back(),
                ),
              ],
            ),
          );
        },
      ),
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(0, 62, 33, 33),
    );
  }

  Widget _categoryDropdown(FeatureArtsController c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: DropdownButton<int>(
        value: c.selectedCategoryIndex,
        isExpanded: true,
        underline: SizedBox.shrink(),
        icon: Icon(Icons.arrow_drop_down, color: AppColors.bodyClr),
        items: List.generate(
          c.categories.length,
          (i) => DropdownMenuItem<int>(
            value: i,
            child: CommonText(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.bodyClr,
              text: c.categories[i],
            ),
          ),
        ),
        onChanged: (i) {
          if (i != null) c.setCategoryIndex(i);
        },
      ),
    );
  }

  Widget _priceRange(FeatureArtsController c) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _priceBubble(c.priceRange.start.toInt()),
            _priceBubble(c.priceRange.end.toInt()),
          ],
        ),
        RangeSlider(
          values: c.priceRange,
          min: c.minPrice,
          max: c.maxPrice,
          activeColor: AppColors.primaryColor,
          inactiveColor: AppColors.stroke,
          onChanged: (v) => c.setPrice(v),
        ),
      ],
    );
  }

  Widget _priceBubble(int amount) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: CommonText(
        text: '\$$amount',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _statusChip(FeatureArtsController c, String label) {
    final bool selected = c.status == label;
    return InkWell(
      onTap: () => c.setStatus(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: selected ? AppColors.primaryColor : AppColors.stroke),
        ),
        child: CommonText(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : AppColors.bodyClr,
        ),
      ),
    );
  }

  Widget _sheetContainer({required String title, required Widget child}) {
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
                    text: title,
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
            child,
          ],
        ),
      ),
    );
  }
}
