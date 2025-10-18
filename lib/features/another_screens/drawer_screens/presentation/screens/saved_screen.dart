import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/controller/saved_controller.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/enum/enum.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

import '../widgets/saved_screen_grid_section.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.searchBg,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
        title: CommonText(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.titleColor,
          text: AppString.saved,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 23.sp, color: AppColors.titleColor),
        ),
      ),

      body: SingleChildScrollView(
        child: GetBuilder(
          init: SavedController(),
          builder: (controller) {
            return Column(
              children: [
                15.height,

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(left: 23.w),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.updateCategorySelected(type: SaveType.arts.value);
                          },
                          child: categoryItem(
                            isSelected: controller.isSelected == SaveType.arts.value
                                ? true
                                : false,
                            title: AppString.art,
                          ),
                        ),

                        7.width,

                        InkWell(
                          onTap: () {
                            controller.updateCategorySelected(
                              type: SaveType.exhibition.value,
                            );
                          },
                          child: categoryItem(
                            isSelected: controller.isSelected == SaveType.exhibition.value
                                ? true
                                : false,
                            title: AppString.exhibition,
                          ),
                        ),
                        7.width,

                        InkWell(
                          onTap: () {
                            controller.updateCategorySelected(type: SaveType.event.value);
                          },
                          child: categoryItem(
                            isSelected: controller.isSelected == SaveType.event.value
                                ? true
                                : false,
                            title: AppString.events,
                          ),
                        ),
                        7.width,

                        InkWell(
                          onTap: () {
                            controller.updateCategorySelected(
                              type: SaveType.learning.value,
                            );
                          },
                          child: categoryItem(
                            isSelected: controller.isSelected == SaveType.learning.value
                                ? true
                                : false,
                            title: AppString.learningMaterials,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                12.height,

                SavedScreenGridSection(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget categoryItem({isSelected, title}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: CommonText(
        color: isSelected ? AppColors.white : AppColors.titleColor,
        text: title,
      ),
    );
  }
}
