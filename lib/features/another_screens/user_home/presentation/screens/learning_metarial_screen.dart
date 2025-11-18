
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/component/text_field/common_text_field.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/learning_medarials_item.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/controllers/learning_materials_controller.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_loader.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class LearningMetarialScreen extends StatelessWidget {
  LearningMetarialScreen({super.key});


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
          text: AppString.learningMaterials,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 23.sp, color: AppColors.titleColor),
        ),
      ),
      body: GetBuilder<LearningMaterialsController>(
        init: LearningMaterialsController(),
        builder: (controller) {
          final materials = controller.filteredMaterials;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.height,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CommonTextField(
                    onChanged: controller.onSearchChanged,
                    suffixIcon: Container(
                      margin: EdgeInsets.all(7.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: Icon(Icons.search, color: AppColors.white),
                    ),
                    borderColor: AppColors.stroke,
                    fillColor: AppColors.searchBg,
                    hintText: AppString.searchLearningMaterials,
                  ),
                ),

                15.height,

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: AppLoader(
                    isLoading: controller.isLoading,
                    loaderChild: SizedBox(
                      height: 250.h,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    child: materials.isEmpty
                        ? SizedBox(
                            height: 80.h,
                            child: Row(
                              children: [
                                CommonText(
                                  text: controller.isLoading
                                      ? AppString.loading
                                      : AppString.dataEmpty,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: materials.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 20,
                              mainAxisExtent: 190.h,
                            ),
                            itemBuilder: (context, index) {
                              final item = materials[index];
                              return LearningMedarialsItem(
                                title: item.title,
                                description: item.overview,
                                imageUrl: item.displayThumbnail,
                                isSaved: item.isOnFavorite,
                                onTapSave: () => controller.toggleFavorite(index: index),
                                onTap: () {
                                  log('Opening learning detail => ${item.id}');
                                  Get.toNamed(
                                    AppRoutes.learningMaterialsDetailsScreen,
                                    arguments: {'learningId': item.id},
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
