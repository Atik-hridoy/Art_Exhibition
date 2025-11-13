import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/helpers/image_helper.dart';
import '../controller/profile_controller.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/app_string.dart';
import '../widgets/edit_profile_all_filed.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xFFFBFCFD),
          /// App Bar Sections Starts here
          appBar: AppBar(
            surfaceTintColor: AppColors.transparent,
            shadowColor: AppColors.transparent,
            backgroundColor: AppColors.white,
            leading: InkWell(
                onTap: (){
                  Get.back();
                },
                child: Icon(
                  color: AppColors.titleColor,
                  Icons.arrow_back_ios, size: 23.sp,)),
            centerTitle: true,
            title: const CommonText(
              text: AppString.editInformation,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          /// Body Sections Starts here
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  /// User Profile image here
                  Stack(
                    children: [
                      Center(
                        child: Container(

                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.stroke),
                            shape: BoxShape.circle,
                            color: AppColors.white
                          ),
                          child: _buildProfileImage(controller),
                        ),
                      ),

                      /// image change icon here
                      Positioned(
                        bottom: 0,
                        left: Get.width * 0.48,
                        child: InkWell(
                          onTap: controller.getProfileImage,
                          child: Container(
                            padding: EdgeInsets.all(5.r),
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: AppColors.primaryColor),
                              color: AppColors.gridClr,
                              shape: BoxShape.circle
                            ),
                            child: Icon(
                                size: 15.sp,
                                Icons.edit_outlined, color:AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),

                  10.height,
                  CommonText(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.titleColor,
                      text: controller.getUserName()),

                  25.height,

                  /// user all information filed here
                  EditProfileAllFiled(controller: controller),
                  30.height,

                  /// Submit Button here
                  CommonButton(
                    titleText: AppString.update,
                    isLoading: controller.isLoading,
                    onTap: controller.editProfileRepo,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build profile image with current/selected image
  Widget _buildProfileImage(ProfileController controller) {
    // If user selected a new image, show it
    if (controller.image != null) {
      return ClipOval(
        child: Image.file(
          File(controller.image!),
          width: 100.h,
          height: 100.h,
          fit: BoxFit.fill,
        ),
      );
    }
    
    // If user has profile image from API, show it
    if (controller.getProfileImageUrl().isNotEmpty) {
      return ClipOval(
        child: CommonImage(
          imageSrc: ImageHelper.buildImageUrl(controller.getProfileImageUrl()),
          height: 100,
          width: 100,
          fill: BoxFit.fill,
        ),
      );
    }
    
    // Show default image
    return ClipOval(
      child: CommonImage(
        imageSrc: AppImages.female,
        height: 100,
        fill: BoxFit.fill,
        width: 100,
      ),
    );
  }
}
