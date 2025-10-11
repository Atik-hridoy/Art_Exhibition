import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/features/onboarding_screen/controller/choose_role_controller.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/config/route/app_routes.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<ChooseRoleController>(
        init: ChooseRoleController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                5.height,

                CommonImage(
                  fill: BoxFit.fill,
                  imageSrc: AppImages.logo,
                  height: 80.r,
                  width: 80.r,
                ),

                22.height,

                CommonText(
                  text: AppString.chooseRoleTitle,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),

                8.height,

                CommonText(
                  text: AppString.chooseRoleSubtitle,
                  fontSize: 13,
                  color: AppColors.bodyClr,

                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),

                20.height,

                _RoleTile(
                  index: 0,
                  image: AppImages.generalUserCollector,
                  title: AppString.roleVisitorTitle,
                  subtitle: AppString.roleVisitorDes,
                  isSelected: controller.selectedIndex.value == 0,
                  onTap: () => controller.select(0),
                  leadingIcon: Icons.account_circle_outlined,
                ),
                10.height,
                _RoleTile(
                  index: 1,
                  image: AppImages.artistCurator,
                  title: AppString.roleArtistTitle,
                  subtitle: AppString.roleArtistDes,
                  isSelected: controller.selectedIndex.value == 1,
                  onTap: () => controller.select(1),
                  leadingIcon: Icons.palette_outlined,
                ),
                10.height,
                _RoleTile(
                  index: 2,
                  image: AppImages.collectionActive,
                  title: AppString.roleCollectorTitle,
                  subtitle: AppString.roleCollectorDes,
                  isSelected: controller.selectedIndex.value == 2,
                  onTap: () => controller.select(2),
                  leadingIcon: Icons.collections_bookmark_outlined,
                ),
                10.height,
                _RoleTile(
                  index: 3,
                  image: AppImages.curator,
                  title: AppString.roleCuratorTitle,
                  subtitle: AppString.roleCuratorDes,
                  isSelected: controller.selectedIndex.value == 3,
                  onTap: () => controller.select(3),
                  leadingIcon: Icons.workspace_premium_outlined,
                ),
                10.height,
                _RoleTile(
                  index: 4,
                  image: AppImages.museumEdu,
                  title: AppString.roleMuseumTitle,
                  subtitle: AppString.roleMuseumDes,
                  isSelected: controller.selectedIndex.value == 4,
                  onTap: () => controller.select(4),
                  leadingIcon: Icons.museum_outlined,
                ),
                12.height,
                _RoleTile(
                  index: 5,
                  image: AppImages.education,
                  title: AppString.roleEducationalInstitutionTitle,
                  subtitle: AppString.roleEducationalInstitutionDes,
                  isSelected: controller.selectedIndex.value == 5,
                  onTap: () => controller.select(5),
                  leadingIcon: Icons.school_outlined,
                ),

                18.height,

                CommonButton(
                  titleText: AppString.continues,
                  buttonRadius: 50,
                  onTap: () {
                    // controller.selectedRoleKey
                    Get.offAllNamed(
                      AppRoutes.signUp,
                      arguments: {'role': controller.selectedRoleKey},
                    );
                  },
                ),

                16.height,
              ],
            ),
          );
        },
      ),
    );
  }
}

class _RoleTile extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData leadingIcon;

  const _RoleTile({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.isSelected,
    required this.onTap,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.stroke),
          boxShadow: const [
            BoxShadow(color: AppColors.stroke, blurRadius: 2, offset: Offset(0, 1)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40.r,
              width: 40.r,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.yelloFade,
                shape: BoxShape.circle,
              ),
              child: CommonImage(fill: BoxFit.fill, imageSrc: image),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,

                    color: AppColors.titleColor,
                    maxLines: 2,
                  ),
                  6.height,
                  CommonText(
                    text: subtitle,
                    fontSize: 12,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w400,
                    color: AppColors.bodyClr,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            10.width,
            _Radio(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _Radio extends StatelessWidget {
  final bool isSelected;
  const _Radio({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.r,
      width: 22.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : Colors.grey,
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                height: 12.r,
                width: 12.r,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}
