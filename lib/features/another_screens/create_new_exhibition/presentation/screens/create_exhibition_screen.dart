import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/component/text_field/common_text_field.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

import '../controllers/create_exhibition_controller.dart';

class CreateExhibitionScreen extends StatelessWidget {
  const CreateExhibitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateExhibitionController>(
      init: CreateExhibitionController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            shadowColor: AppColors.transparent,
            surfaceTintColor: AppColors.transparent,
            title: CommonText(
              text: AppString.createArtwork,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
            ),
            leading: InkWell(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, size: 22.sp, color: AppColors.titleColor),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Upload area
                if (controller.imagePaths.isEmpty)
                  InkWell(
                    onTap: controller.tapUpload,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      decoration: BoxDecoration(
                        color: AppColors.searchBg,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.stroke,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CommonImage(
                            imageSrc: AppImages.uploadArtwork,
                            height: 28.h,
                            width: 28.h,
                            fill: BoxFit.contain,
                          ),
                          8.height,
                          CommonText(
                            text: AppString.tapToUploadImage,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.titleColor,
                          ),
                          4.height,
                          CommonText(
                            text:
                                '${AppString.photos}: ${controller.photosCount.toString().padLeft(1, '0')}/05 : ${AppString.chooseYourMainPhotoFirstShort}',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bodyClr,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  _imagesGrid(controller),

                16.height,
                _label(AppString.artworkTitle),
                8.height,
                CommonTextField(
                  borderColor: AppColors.stroke,
                  fillColor: AppColors.white,
                  hintText: AppString.enterArtworkTitle,
                  controller: controller.titleCtrl,
                ),

                12.height,
                _label(AppString.category),
                8.height,
                GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: _categorySelector(controller),
                ),

                12.height,
                _label(AppString.description),
                8.height,
                CommonTextField(
                  borderColor: AppColors.stroke,
                  fillColor: AppColors.white,
                  hintText: AppString.describeYourArtwork,
                  controller: controller.descriptionCtrl,
                  maxline: 4,
                ),

                12.height,
                _label(AppString.dimensions),
                8.height,
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        hintText: AppString.widthIn,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                        keyboardType: TextInputType.number,
                        controller: controller.widthCtrl,
                      ),
                    ),
                    12.width,
                    Expanded(
                      child: CommonTextField(
                        hintText: AppString.heightIn,
                        borderColor: AppColors.stroke,
                        fillColor: AppColors.white,
                        keyboardType: TextInputType.number,
                        controller: controller.heightCtrl,
                      ),
                    ),
                  ],
                ),

                12.height,
                _label(AppString.authentication),
                8.height,
                _authSelector(controller),

                12.height,
                _label(AppString.price),
                8.height,
                CommonTextField(
                  prefixText: '\$',
                  hintText: '15',
                  borderColor: AppColors.stroke,
                  fillColor: AppColors.white,
                  keyboardType: TextInputType.number,
                  controller: controller.priceCtrl,
                ),

                18.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CommonText(
                        text: AppString.acceptOffersFromBuyers,
                        fontSize: 14,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        color: AppColors.titleColor,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      width: 42,
                      child: Switch(
                        value: controller.acceptOffers,
                        activeColor: AppColors.primaryColor,
                        onChanged: controller.toggleOffers,
                      ),
                    ),
                  ],
                ),

                24.height,
                CommonButton(
                  titleText: AppString.createExhibition,
                  buttonRadius: 60,
                  onTap: controller.submit,
                ),
                60.height,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _label(String text) {
    return CommonText(
      text: text,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.titleColor,
    );
  }

  Widget _imagesGrid(CreateExhibitionController c) {
    final canAddMore = c.imagePaths.length < 5;
    final tiles = <Widget>[];

    for (int i = 0; i < c.imagePaths.length; i++) {
      tiles.add(
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.file(
                File(c.imagePaths[i]),
                height: 90.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: InkWell(
                onTap: () => c.removeImageAt(i),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 16.sp),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (canAddMore) {
      tiles.add(
        InkWell(
          onTap: c.tapUpload,
          child: Container(
            height: 90.h,
            decoration: BoxDecoration(
              color: AppColors.searchBg,
              border: Border.all(color: AppColors.stroke),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: AppColors.bodyClr),
                  4.height,
                  CommonText(
                    text: AppString.upload,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.bodyClr,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      itemCount: tiles.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
        mainAxisExtent: 90.h,
      ),
      itemBuilder: (_, i) => tiles[i],
    );
  }

  Widget _categorySelector(CreateExhibitionController c) {
    return InkWell(
      onTap: () async {
        // Close keyboard first
        // FocusScope.of(Get.context!).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();

        // Wait until the keyboard is fully dismissed
        await Future.delayed(const Duration(milliseconds: 300));

        // Then show the sheet
        _showCategorySheet();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Row(
          children: [
            Expanded(
              child: CommonText(
                text: c.categories[c.selectedCategoryIndex],
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.bodyClr,
                textAlign: TextAlign.start,
              ),
            ),
            InkWell(
              onTap: () {
                // FocusManager.instance.primaryFocus?.unfocus();
                _showCategorySheet();
              },
              child: Icon(Icons.arrow_drop_down, color: AppColors.bodyClr),
            ),
          ],
        ),
      ),
    );
  }
  // FocusManager.instance.primaryFocus?.unfocus(),

  void _showCategorySheet() {
    Get.bottomSheet(
      GetBuilder<CreateExhibitionController>(
        builder: (c) {
          return _sheetContainer(
            title: 'Select Category',
            child: Column(
              children: List.generate(
                c.categories.length,
                (i) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _categoryTile(c, i, c.categories[i]),
                ),
              ),
            ),
          );
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _categoryTile(CreateExhibitionController c, int index, String label) {
    final bool selected = c.selectedCategoryIndex == index;
    return InkWell(
      onTap: () {
        c.setCategoryIndex(index);
        Get.back();
      },
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

  Widget _authSelector(CreateExhibitionController c) {
    return InkWell(
      onTap: () async {
        // Close keyboard first
        // FocusScope.of(Get.context!).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();

        // Wait until the keyboard is fully dismissed
        await Future.delayed(const Duration(milliseconds: 300));

        // Then show the sheet
        _showAuthSheet();
      },

      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Row(
          children: [
            Expanded(
              child: CommonText(
                text: c.authentications[c.selectedAuthIndex],
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.bodyClr,
                textAlign: TextAlign.start,
              ),
            ),
            InkWell(
              onTap: _showAuthSheet,
              child: Icon(Icons.arrow_drop_down, color: AppColors.bodyClr),
            ),
          ],
        ),
      ),
    );
  }

  void _showAuthSheet() {
    Get.bottomSheet(
      GetBuilder<CreateExhibitionController>(
        builder: (c) {
          return _sheetContainer(
            title: 'Select Authenticity',
            child: Column(
              children: [
                ...List.generate(
                  c.authentications.length,
                  (i) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: _authTile(c, i, c.authentications[i]),
                  ),
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

  Widget _authTile(CreateExhibitionController c, int index, String label) {
    final bool selected = c.selectedAuthIndex == index;
    return InkWell(
      onTap: () {
        c.setAuthIndex(index);
        Get.back();
      },
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
            Container(width: double.infinity, height: 1, color: AppColors.stroke),

            22.height,

            child,
            20.height,
            CommonButton(
              titleText: AppString.continues,
              buttonRadius: 60,
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
