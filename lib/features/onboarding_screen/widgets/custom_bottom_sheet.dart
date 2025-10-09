import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import '../../../component/button/common_button.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_string.dart';
import 'dot_indecator.dart';

class CustomBottomSheet extends StatelessWidget {
  final VoidCallback signUp;
  final VoidCallback signIn;
  final int index;
  final List titleList;
  final List desList;
  const CustomBottomSheet({
    super.key,
    required this.index,
    required this.signUp,
    required this.titleList,
    required this.desList,
    required this.signIn,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.maxFinite,
        height: 340.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 51.h),

          child: Column(
            children: [
              CommonText(
                fontSize: 20,
                maxLines: 1,
                fontWeight: FontWeight.w700,

                text: titleList[index],
              ),
              5.height,
              CommonText(
                fontSize: 12,

                fontWeight: FontWeight.w400,
                color: AppColors.bodyClr,
                maxLines: 4,

                text: desList[index],
              ),

              36.height,
              // Wrap only DotIndicator with Obx
              DotIndicator(selectIndex: index),

              10.height,

              const Spacer(),
              CommonButton(onTap: signUp, titleText: AppString.signUp),
              12.height,
              CommonButton(
                borderColor: AppColors.primaryColor,
                titleColor: AppColors.primaryColor,
                buttonColor: AppColors.transparent,
                onTap: signIn,
                titleText: AppString.logIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
