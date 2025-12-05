import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/features/another_screens/related_art_details/presentation/screens/art_details_loading_widgets/art_details_loading.dart';
import 'package:tasaned_project/features/another_screens/related_art_details/presentation/screens/art_details_loading_widgets/releated_art_loading.dart';
import 'package:tasaned_project/features/data_model/feature_arts_model.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_loader.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/component/text_field/common_text_field.dart';

import '../../../../../config/route/app_routes.dart';
import '../../../user_home/presentation/widgets/arts_item.dart';
import '../widgets/banner_dot_indecator.dart';
import '../controller/art_details_controller.dart';

class RelatedArtDetailsScreen extends StatelessWidget {
  RelatedArtDetailsScreen({super.key});

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

      body: GetBuilder<RelatedArtDetailsController>(
        init: RelatedArtDetailsController(),
        builder: (controller) {
          // Check for navigation updates
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final newArtId = Get.arguments?['artId'] ?? '';
            if (newArtId.isNotEmpty && newArtId != controller.artID) {
              controller.refreshArtDetails(newArtId);
            }
          });
          
          List<String>? images = controller.artData?.images;
          String? title = controller.artData?.title;
          String? category = controller.artData?.category?.title;
          num? price = controller.artData?.price ?? 0;
          String? description = controller.artData?.description;
          Dimensions? dimensions = controller.artData?.dimensions;
          String? authentication = controller.artData?.authentication;
          String? artistName = controller.artData?.artist?.name;
          String? role = controller.artData?.artist?.role;
          String? artistImage = controller.artData?.artist?.profileImage;
          String? about = controller.artData?.artist?.about ?? 'N/A';
          String? artistId = controller.artData?.artist?.id ?? 'N/A';

          return AppLoader(
            isLoading: controller.isArtDataLoading,
            loaderChild: ArtDetailsLoading(),
            child: SingleChildScrollView(
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
                                  itemCount: images == null ? 0 : images.length,
                                  onPageChanged: (i) => controller.setIndex(i),
                                  itemBuilder: (context, index) => CommonImage(
                                    height: 300,
                                    width: double.infinity,
                                    fill: BoxFit.cover,
                                    imageSrc: images == null
                                        ? ''
                                        : ApiEndPoint.imageUrl + images[index],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () => controller.saveToggle(),
                                  child: Container(
                                    padding: EdgeInsets.all(6.r),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: controller.isSaved
                                        ? Icon(
                                            Icons.favorite,
                                            size: 18.sp,
                                            color: AppColors.titleColor,
                                          )
                                        : Icon(
                                            Icons.favorite_border,
                                            size: 18.sp,
                                            color: AppColors.titleColor,
                                          ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Column(
                                  children: [
                                    BannerDotIndecator(
                                      selectIndex: controller.currentIndex,
                                      maxdot: images == null ? 0 : images.length,
                                    ),
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
                          text: title ?? '', //"Whispers of the Forest",
                        ),
                        CommonText(
                          top: 5,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyClr,
                          text: category ?? 'N/A', // "Abstract",
                        ),
                        CommonText(
                          top: 8,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                          text: price.toString(), // "\$2,500",
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
                              description ??
                              'N/A', //     "A captivating and evocative artwork that blends nature's serene beauty with abstract elements, capturing the mystical essence of the forest.",
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
                              text:
                                  'Height: ${dimensions?.height ?? 'N/A'}${dimensions?.height != null ? 'cm' : ''}, Width: ${dimensions?.width ?? 'N/A'}${dimensions?.width != null ? 'cm' : ''}', // " 13 × 15 5/8 in (33 × 39.7 cm)",
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
                              text: authentication ?? 'N/A',
                              // "Hand-signed by artist",
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
                                        imageSrc: artistImage != null
                                            ? ApiEndPoint.imageUrl + artistImage
                                            : "",
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
                                          text: artistName ?? 'N/A', //"John Currin",
                                        ),
                                        CommonText(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.titleColor,
                                          text: role ?? 'Role Unknown',
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        controller.isFollowing
                                            ? controller.toggleUnfollow(
                                                artistID: artistId,
                                              )
                                            : controller.toggleFollow(artistID: artistId);
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
                                text: about,
                                //  "John Currin’s provocative portraits blend satirical exaggeration with grotesque beauty, masterfully ...Read more..",
                              ),

                              15.height,
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: AppColors.normalGray2,
                              ),

                              20.height,

                              // Related Arts - Skip for related art details view
                              // CommonText(
                              //   fontSize: 16,
                              //   fontWeight: FontWeight.w600,
                              //   color: AppColors.titleColor,
                              //   text: "Related Arts",
                              // ),
                              // 16.height,

                              // RelatedArtScreen(controller: controller),

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
                                      onTap: controller.artData == null
                                          ? null
                                          : () {
                                              Get.toNamed(
                                                AppRoutes.checkOutScreen,
                                                arguments: {
                                                  'artId': controller.artData?.id ?? '',
                                                  'price': controller.artData?.price ?? 0,
                                                },
                                              );
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
          );
        },
      ),
    );
  }
}

class RelatedArtScreen extends StatelessWidget {
  final RelatedArtDetailsController controller;
  const RelatedArtScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppLoader(
      isLoading: controller.isArtDataLoading,
      loaderChild: ReleatedArtLoading(),
      child:
          controller.relatedArtList?.length == null ||
              controller.relatedArtList?.length == 0
          ? SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [CommonText(text: AppString.noRelatedArts, color: Colors.grey)],
              ),
            )
          : SizedBox(
              height: 182.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.relatedArtList!.length < 5
                    ? controller.relatedArtList!.length
                    : 5,
                itemBuilder: (context, index) {
                  final relatedArtId = controller.relatedArtList?[index].id ?? '';
                  return Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: InkWell(
                      onTap: () => Get.toNamed(
                        AppRoutes.artDetailsScreen,
                        arguments: {
                          'screenType': 'relatedArt',
                          'artId': relatedArtId,
                        },
                      ),
                      child: ArtsItem(
                        imageUrl: controller.relatedArtList?[index].image ?? '',
                        price: controller.relatedArtList?[index].price as int,
                        title: controller.relatedArtList?[index].title ?? '',
                        isSaved: controller.relatedArtList?[index].isOnFavorite ?? false,
                        onTapSave: () async {
                          await controller.saveRelatedArtToggle(index: index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

// =============== Make an Offer Dialog ===============
void _showMakeOfferDialog(BuildContext context) {
  Get.dialog(
    GetBuilder<RelatedArtDetailsController>(
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
