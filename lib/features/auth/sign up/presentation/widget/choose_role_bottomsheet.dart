import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/features/auth/sign%20up/presentation/controller/sign_up_controller.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_string.dart';

void chooseRoleBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppColors.white,

    context: context,
    builder: (BuildContext context) {
      return GetBuilder<SignUpController>(
        builder: (controller) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            padding: EdgeInsets.all(16),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CommonText(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.titleColor,
                          text: AppString.chooseRole,
                        ),

                        CommonText(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.red,
                          text: "*",
                        ),
                      ],
                    ),

                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.bodyClr),
                        ),
                        child: Icon(size: 15.sp, Icons.clear, color: AppColors.bodyClr),
                      ),
                    ),
                  ],
                ),

                20.height,
                Expanded(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.roleList.length,
                    itemBuilder: (context, index) {
                      var category = controller.roleList[index];
                      return Container(
                        height: 48.h,
                        margin: EdgeInsets.only(top: 7.h),
                        width: double.infinity,
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(width: 1.h, color: AppColors.bodyClr),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            CommonText(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              text: category,
                            ),
                            SizedBox(
                              height: 24.h,
                              width: 24.w,
                              child: Radio(
                                activeColor: AppColors.primaryColor,
                                value: category,
                                groupValue: controller.selectedRole,
                                onChanged: (val) {
                                  controller.changeChooseRole(val);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                30.height,

                CommonButton(
                  onTap: () {
                    Get.back();
                  },
                  titleText: AppString.continues,
                ),

                40.height,
              ],
            ),
          );
        },
      );
    },
  );
}
