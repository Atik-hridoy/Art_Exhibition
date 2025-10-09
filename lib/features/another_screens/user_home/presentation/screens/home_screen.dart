import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/component/bottom_nav_bar/common_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/component/text_field/common_text_field.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';

import '../widgets/custom_drawer.dart';
import '../widgets/list_item_section.dart';
import '../widgets/user_app_bar.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFB),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 0),
        child: PreferredSize(
          preferredSize: Size(double.infinity, 0),
          child: AppBar(
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.transparent,
            shadowColor: AppColors.transparent,

            title: CommonText(text: "Home screen"),
          ),
        ),
      ),

      drawer: CustomDrawer(),

      body: Column(
        children: [
          UserAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        CommonTextField(
                          fillColor: AppColors.searchBg,
                          hintText: AppString.searchHintText,
                          textColor: AppColors.searchText,
                          borderColor: AppColors.searchText,
                          onTap: () {
                            Get.toNamed(AppRoutes.searchScreen);
                          },
                          suffixIcon: Container(
                            margin: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(color: AppColors.white, Icons.search),
                          ),
                        ),
                        ListItemSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CommonBottomNavBar(currentIndex: 0),
    );
  }
}
