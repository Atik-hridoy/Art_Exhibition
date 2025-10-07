
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';


class MyCoursesVideoScreen extends StatelessWidget {
  const MyCoursesVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: AppBar(
          surfaceTintColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          backgroundColor: AppColors.white,
        ),
      ),
      
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CommonImage(
                    width: Get.width,
                    fill: BoxFit.cover,
                    imageSrc: AppImages.learningBanner),
                
                Center(
                  child: Container(
                    padding: EdgeInsets.all(7.r),
                    margin: EdgeInsets.only(top: 100),
        
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      shape: BoxShape.circle
                    ),
                                  child: Icon(
                    color: AppColors.white,
                    size: 20.sp,
                    Icons.pause),
                                ),
                ),

                Positioned(
                  
                top: 15,
                left: 15,
                  child: InkWell(
                    
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios))),
                
                Positioned(
                    bottom: 2,
                    left: 0,
                    right: 0,
                    child: Column(
                  
                  children: [
                    
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                              text: "4:10/6:10 "),
        
                          Icon(
                              color: AppColors.white,
                              Icons.fullscreen)
        
                        ],
                      ),
                    ),
        
                    7.height,
                    
                    CommonImage(imageSrc: AppImages.videoDuration),
        
                    15.height
                  ],
                ))
              ],
            ),
        
            30.height,
        
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleColor,
                      text: "Introduction to Acrylics & Basic Techniques"),
        
                  11.height,
        
                  CommonText(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyClr,
                      maxLines: 5,
                      textAlign: TextAlign.justify,
                      text: "A concise explanation of the lesson’s content: “In this first week, we’ll introduce you to acrylic painting. Learn about essential materials like acrylic paints, brushes, and canvases. See more"),
                ],
              ),
            ),


         ],
        ),
      ),
    );
  }
}
