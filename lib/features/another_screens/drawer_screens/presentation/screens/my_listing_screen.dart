import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

import '../widgets/my_list_item.dart';

class MyListingScreen extends StatelessWidget {
  const MyListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.myListBg,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
        title: CommonText(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
          text: AppString.myListing,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 23.sp, color: AppColors.titleColor),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              12.height,

              Row(
                children: [
                  Icon(
                    size: 20.sp,
                    color: AppColors.titleColor,
                    Icons.filter_alt_outlined,
                  ),

                  CommonText(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                    text: AppString.filter,
                  ),

                  Spacer(),

                  CommonText(
                    fontSize: 12,
                    right: 6,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                    text: AppString.filter,
                  ),

                  Icon(size: 20.sp, color: AppColors.titleColor, Icons.sort_outlined),
                ],
              ),

              15.height,

              SizedBox(
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MyListItem();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
