import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/artist_details/presentation/controller/artist_details_controller.dart';
import 'package:tasaned_project/features/data_model/artist_details_model.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/constants/app_string.dart';
import '../../../../../utils/helpers/image_helper.dart';

class ArtistDetailsHeadingSection extends StatelessWidget {
  final ArtistDetailsController controller;
  final ArtistDetailsModel artist;

  const ArtistDetailsHeadingSection({super.key, required this.controller, required this.artist});

  @override
  Widget build(BuildContext context) {
    final coverImage = artist.cover.isNotEmpty
        ? ImageHelper.buildImageUrl(artist.cover)
        : AppImages.manBg;
    final profileImage = artist.profileImage.isNotEmpty
        ? ImageHelper.buildImageUrl(artist.profileImage)
        : AppImages.female;

    return Column(
      children: [

        Stack(clipBehavior: Clip.none,
          children: [
            CommonImage(
                width: double.maxFinite,
                height: 180,
                imageSrc: coverImage),

            Positioned(
                top: 8,
                left: 20,
                child:InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios,size: 20.sp,color: AppColors.bodyClr,)) ),

            Positioned(
                left: 24,
                bottom: -34.h
                ,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 4, color: AppColors.white)
                  ),
                  child: ClipOval(
                    child: CommonImage(
                        height: 100,
                        width: 100,
                        fill: BoxFit.cover,
                        imageSrc: profileImage),
                  ),
                ))
          ],
        ),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              42.height,
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: CommonText(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.titleColor,
                              right: 6,
                              text: artist.name).start,
                        ),
                        if (artist.verified)
                          CommonImage(imageSrc: AppImages.verified),
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: controller.toggleFollowing,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.stroke),
                          borderRadius: BorderRadius.circular(6.r)
                      ),
                      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                      child: Row(
                        children: [
                          Icon(
                            controller.isFollowing ? Icons.person : Icons.person_add,
                            size: 20,
                            color: AppColors.bodyClr,
                          ),
                          CommonText(
                            fontSize: 12,
                            left: 7,
                            fontWeight: FontWeight.w400,
                            color:  AppColors.titleColor,
                            text: controller.isFollowing ? "Following" : AppString.follow,
                          )
                        ],
                      ),
                    ),
                  ),

                  8.width,

                  InkWell(

                    onTap: (){
                      Get.toNamed(AppRoutes.message);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.stroke),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(Icons.message_outlined, size: 18, color: AppColors.titleColor),
                    ),
                  )

                ],
              ),

              Row(
                children: [
                  Icon(Icons.group_outlined, size: 14, color: AppColors.bodyClr),
                  6.width,
                  CommonText(
                    color: AppColors.bodyClr,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    text: "${artist.role} | ${artist.followers} ${AppString.followers}",
                  )
                ],
              ),
              5.height,






              10.height,

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 26.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          InkWell(
                  
                              onTap: (){
                                controller.updateType(type: "aboutUS");
                              },
                              child: CommonText(
                  
                                  fontSize: 16,
                                  fontWeight: controller.isTypeSelected=="aboutUS"?FontWeight.w600:FontWeight.w400,
                                  color: controller.isTypeSelected=="aboutUS"?AppColors.titleColor:AppColors.bodyClr,
                                  text: AppString.about)),
                  
                          6.height,
                          controller.isTypeSelected=="aboutUS"  ? Container(
                            height: 5,
                            width: 67.w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r), topRight: Radius.circular(6.r))
                            ),
                          ):SizedBox()
                        ],
                      ),
                  
                      30.width,
                  
                  
                      Column(
                        children: [
                          InkWell(
                  
                              onTap: (){
                                controller.updateType(type: "artWork");
                              },
                              child: CommonText(
                                  fontSize: 16,
                                  fontWeight: controller.isTypeSelected=="artWork"?FontWeight.w600:FontWeight.w400,
                                  color: controller.isTypeSelected=="artWork"?AppColors.titleColor:AppColors.bodyClr,
                                  text: "Artwork")),
                  
                          6.height,
                          controller.isTypeSelected=="artWork"  ? Container(
                            height: 5,
                            width: 80.w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r), topRight: Radius.circular(6.r))
                            ),
                          ):SizedBox()
                        ],
                      ),
                  
                      22.width,
                  
                      Column(
                        children: [
                          InkWell(
                              onTap: (){
                                controller.updateType(type: "exhibition");
                              },
                              child: CommonText(
                                  fontSize: 16,
                                  fontWeight: controller.isTypeSelected=="exhibition"?FontWeight.w600:FontWeight.w400,
                                  color: controller.isTypeSelected=="exhibition"?AppColors.titleColor:AppColors.bodyClr,
                                  text: AppString.exhibition)),
                  
                          6.height,
                          controller.isTypeSelected=="exhibition"  ? Container(
                            height: 5,
                            width: 90.w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r), topRight: Radius.circular(6.r))
                            ),
                          ):SizedBox()
                        ],
                      ),
                  
                      22.width,
                  
                      Column(
                        children: [
                          InkWell(
                              onTap: (){
                                controller.updateType(type: "event");
                              },
                              child: CommonText(
                                  fontSize: 16,
                                  fontWeight: controller.isTypeSelected=="event"?FontWeight.w600:FontWeight.w400,
                                  color: controller.isTypeSelected=="event"?AppColors.titleColor:AppColors.bodyClr,
                                  text: AppString.events)),
                  
                          6.height,
                          controller.isTypeSelected=="event"  ? Container(
                            height: 5,
                            width: 70.w,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r), topRight: Radius.circular(6.r))
                            ),
                          ):SizedBox()
                        ],
                      ),
                   
                   
                   
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
