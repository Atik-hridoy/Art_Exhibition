import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../controller/notification_settings_controller.dart';


class NotificationSettings extends StatelessWidget {
  const NotificationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shadowColor: AppColors.transparent,
        title:CommonText(

            fontSize: 16,
            fontWeight: FontWeight.w600,
            text: AppString.notifications),
        surfaceTintColor: AppColors.transparent,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            color: AppColors.textFiledColor,
            Icons.arrow_back_ios,
            size: 23.sp,
          ),
        ),
      ),

      body: GetBuilder(
        init: NotificationSettingsController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                30.height,
                notificationSettingItem(
                  title: AppString.bookingUpdates,
                  value: controller.isBookingUpdateSwitched,
                  onChanged: (bool newValue) {
                    controller.toggleBookingUpdateSwitch(newValue);
                  },
                ),
                15.height,
                notificationSettingItem(
                  title: AppString.chatMessage,
                  value: controller.isChatMessageSwitched,
                  onChanged: (bool newValue) {
                    controller.toggleChatMessageSwitch(newValue);
                  },
                ),

                15.height,
                notificationSettingItem(
                    value: controller.isPaymentSwitched,
                    onChanged: (bool newValue){
                      controller.togglePaymentSwitch(newValue);
                    },
                    title: AppString.chatMessage),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget notificationSettingItem({title, onChanged, value}) {
    return GetBuilder(
      init: NotificationSettingsController(),
      builder: (controller) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  text: title,
                ),

                SizedBox(
                  height: 30,
                  width: 30,
                  child: Switch(
                    activeTrackColor: AppColors.primaryColor,
                    inactiveTrackColor: AppColors.white,

                    activeThumbColor: AppColors.white,
                    value: value,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
            7.height,

            Container(
              height: 1,
              width: double.infinity,
              color: AppColors.normalGray2,
            ),
          ],
        );
      },
    );
  }
}
