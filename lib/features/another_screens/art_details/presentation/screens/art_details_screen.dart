import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/enum/enum.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/component/text_field/common_text_field.dart';

import '../../../../../config/route/app_routes.dart';
import '../../../user_home/presentation/widgets/arts_item.dart';
import '../widgets/banner_dot_indecator.dart';
import '../controller/art_details_controller.dart';

class ArtDetailsScreen extends StatelessWidget {
  ArtDetailsScreen({super.key});

  final String screenType = Get.arguments['screenType'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
        title: CommonText(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
          text: AppString.artDetails,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 23.sp, color: AppColors.titleColor),
        ),
      ),

      body: GetBuilder<ArtDetailsController>(
        init: ArtDetailsController(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ============= Slidable top images =============
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: PageView.builder(
                              controller: controller.pageController,
                              itemCount: controller.images.length,
                              onPageChanged: (i) => controller.setIndex(i),
                              itemBuilder: (context, index) => CommonImage(
                                height: 300,
                                width: double.infinity,
                                fill: BoxFit.cover,
                                imageSrc: controller.images[index],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: EdgeInsets.all(6.r),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                size: 18.sp,
                                color: AppColors.titleColor,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                BannerDotIndecator(selectIndex: controller.currentIndex),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ============= Title, category, price =============
                    CommonText(
                      top: 11,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      text: "Whispers of the Forest",
                    ),
                    CommonText(
                      top: 5,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyClr,
                      text: "Abstract",
                    ),
                    CommonText(
                      top: 8,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                      text: "\$2,500",
                    ),

                    14.height,

                    // ============= Description =============
                    CommonText(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      text: AppString.description,
                    ),
                    CommonText(
                      maxLines: 50,
                      top: 8,
                      textAlign: TextAlign.start,
                      fontSize: 14,
                      color: AppColors.bodyClr,
                      fontWeight: FontWeight.w400,
                      text:
                          "A captivating and evocative artwork that blends nature's serene beauty with abstract elements, capturing the mystical essence of the forest.",
                    ),

                    11.height,

                    Container(height: 1, color: AppColors.normalGray2),

                    20.height,

                    Row(
                      children: [
                        CommonText(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.titleColor,
                          text: "Dimensions:",
                        ),
                        CommonText(
                          left: 5,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.titleColor,
                          text: " 13 × 15 5/8 in (33 × 39.7 cm)",
                        ),
                      ],
                    ),
                    4.height,
                    Row(
                      children: [
                        CommonText(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.titleColor,
                          text: "Authentication: ",
                        ),
                        CommonText(
                          left: 5,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.titleColor,
                          text: "Hand-signed by artist",
                        ),
                      ],
                    ),

                    if (screenType != "myListing")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          15.height,
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: AppColors.normalGray2,
                          ),

                          20.height,

                          // About Artist
                          CommonText(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.titleColor,
                            text: "About Artist",
                          ),
                          17.height,
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.artistDetailsScreen);
                            },
                            child: Row(
                              children: [
                                ClipOval(
                                  child: CommonImage(
                                    height: 40,
                                    width: 40,
                                    fill: BoxFit.cover,
                                    imageSrc: AppImages.female,
                                  ),
                                ),
                                8.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.titleColor,
                                      text: "John Currin",
                                    ),
                                    CommonText(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.titleColor,
                                      text: Role.artist.role,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    controller.toggleFollow();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 7.h,
                                      horizontal: 17.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                      border: Border.all(color: AppColors.stroke),
                                      color: AppColors.transparent,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          controller.isFollowing
                                              ? Icons.person_outline
                                              : Icons.person_add_alt_1_outlined,
                                          size: 14.sp,
                                          color: AppColors.titleColor,
                                        ),
                                        6.width,
                                        CommonText(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          text: controller.isFollowing
                                              ? 'Following'
                                              : AppString.follow,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          12.height,
                          CommonText(
                            maxLines: 5,
                            color: AppColors.bodyClr,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.start,
                            text:
                                "John Currin’s provocative portraits blend satirical exaggeration with grotesque beauty, masterfully ...Read more..",
                          ),

                          15.height,
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: AppColors.normalGray2,
                          ),

                          20.height,

                          // Related Arts
                          CommonText(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.titleColor,
                            text: "Related Arts",
                          ),
                          16.height,
                          SizedBox(
                            height: 182.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: InkWell(
                                    onTap: () => Get.toNamed(AppRoutes.artDetailsScreen),
                                    child: ArtsItem(),
                                  ),
                                );
                              },
                            ),
                          ),

                          30.height,
                        ],
                      ),
                  ],
                ),
              ),

              screenType == "myListing"
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.h),

                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: AppColors.stroke)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          24.height,
                          Row(
                            children: [
                              Expanded(
                                child: CommonButton(
                                  buttonRadius: 60,
                                  borderColor: AppColors.titleColor,
                                  buttonColor: AppColors.transparent,
                                  titleColor: AppColors.titleColor,
                                  onTap: () {
                                    _showMakeOfferDialog(context);
                                  },
                                  titleText: AppString.makeAnOffer,
                                ),
                              ),

                              16.width,

                              Expanded(
                                child: CommonButton(
                                  buttonRadius: 60,
                                  onTap: () {
                                    Get.toNamed(AppRoutes.checkOutScreen);
                                  },

                                  titleText: AppString.purchase,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

              50.height,
            ],
          ),
        ),
      ),
    );
  }
}

// =============== Make an Offer Dialog ===============
void _showMakeOfferDialog(BuildContext context) {
  Get.dialog(
    GetBuilder<ArtDetailsController>(
      builder: (controller) => AnimatedPadding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        duration: const Duration(milliseconds: 200),
        curve: Curves.decelerate,
        child: Dialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                        text: AppString.makeAnOfferTitle,
                      ),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: EdgeInsets.all(2.h),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.bodyClr),
                          ),
                          child: Icon(Icons.close, color: AppColors.bodyClr),
                        ),
                      ),
                    ],
                  ),
                  16.height,

                  CommonText(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                    text: AppString.yourOfferAmount,
                  ),
                  8.height,
                  CommonTextField(
                    controller: controller.offerAmountCtrl,
                    keyboardType: TextInputType.number,
                    borderColor: AppColors.stroke,
                    prefixIcon: Container(
                      margin: EdgeInsets.only(left: 8.w, right: 6.w),
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.stroke),
                        color: AppColors.transparent,
                      ),
                      child: Icon(
                        Icons.attach_money,
                        size: 16.sp,
                        color: AppColors.titleColor,
                      ),
                    ),
                  ),

                  16.height,
                  CommonText(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                    text: AppString.messageOptional,
                  ),
                  8.height,
                  CommonTextField(
                    controller: controller.offerMessageCtrl,
                    hintText: AppString.writeDownAdditionalInfo,
                    borderColor: AppColors.stroke,
                    maxline: 4,
                  ),

                  20.height,
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          titleText: AppString.cancel,
                          titleColor: AppColors.primaryColor,
                          buttonColor: AppColors.transparent,
                          borderColor: AppColors.primaryColor,
                          onTap: () => Get.back(),
                          buttonRadius: 60,
                        ),
                      ),
                      12.width,

                      Expanded(
                        child: CommonButton(
                          titleText: AppString.submitOffer,
                          onTap: () {
                            // Use controller values if needed: controller.offerAmountCtrl.text, controller.offerMessageCtrl.text
                            Get.back();
                            Get.toNamed(AppRoutes.offerSubmittedScreen);
                          },
                          buttonRadius: 60,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
