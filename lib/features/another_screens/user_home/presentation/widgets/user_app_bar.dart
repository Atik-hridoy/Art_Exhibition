import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/constants/app_icons.dart';

class UserAppBar extends StatelessWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width:double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white
      ),
      height: 80.h,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            CommonImage(
                height: 32,
                width: 71,

                imageSrc:AppImages.logoWithText),

            Spacer(),

            // Notification Icon
            _buildNotificationButton(),

            SizedBox(width: 12.w),

            // Drawer Menu Icon
            InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                Icons.menu_rounded,
                size: 30.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build notification button with clean design
  Widget _buildNotificationButton() {
    return InkWell(
      onTap: () => _navigateToNotifications(),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.all(8.r),
        child: CommonImage(
          height: 24.h,
          width: 24.w,
          imageSrc: AppIcons.notification,
        ),
      ),
    );
  }

  /// Navigate to notifications screen
  void _navigateToNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }
}
