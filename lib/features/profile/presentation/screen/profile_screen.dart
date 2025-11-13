import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import '../../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/helpers/image_helper.dart';
import '../controller/profile_controller.dart';
import '../../../../utils/constants/app_images.dart';
import '../widgets/profile_all_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFCFD),


      /// Body Section Starts here
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return controller.isLoadingProfile
              ? _buildLoadingState()
              : _buildProfileContent(controller);
        },
      ),

      /// Bottom Navigation Bar Section Starts here
      bottomNavigationBar:  CommonBottomNavBar(currentIndex:3),
    );
  }

  /// Build loading state
  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  /// Build profile content
  Widget _buildProfileContent(ProfileController controller) {
    return RefreshIndicator(
      onRefresh: controller.refreshProfile,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            /// User Profile Header
            _buildProfileHeader(controller),
            
            /// Profile Menu Items
            ProfileAllItem(),
          ],
        ),
      ),
    );
  }

  /// Build profile header with background and user info
  Widget _buildProfileHeader(ProfileController controller) {
    return Stack(
      children: [
        // Background Image
        CommonImage(
          width: Get.width,
          height: 280.h,
          fill: BoxFit.fill,
          imageSrc: AppImages.profileBg,
        ),

        // Content Overlay
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              45.height,
              
              // Back Button
              _buildBackButton(),
              
              10.height,

              // Profile Image
              _buildProfileImage(controller),

              // User Name
              CommonText(
                top: 18,
                fontSize: 18,
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                text: controller.getUserName(),
              ),

              // User Role
              CommonText(
                top: 4,
                fontSize: 12,
                color: AppColors.white,
                fontWeight: FontWeight.w400,
                text: controller.getUserRole(),
              ),

              75.height,
            ],
          ),
        ),
      ],
    );
  }

  /// Build back button
  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: InkWell(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.white,
        ),
      ).start,
    );
  }

  /// Build profile image with dynamic data
  Widget _buildProfileImage(ProfileController controller) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: CommonImage(
          height: 100,
          width: 100,
          fill: BoxFit.fill,
          imageSrc: controller.getProfileImageUrl().isNotEmpty 
              ? ImageHelper.buildImageUrl(controller.getProfileImageUrl())
              : AppImages.female, // Fallback to default image
        ),
      ),
    ).center;
  }
}
