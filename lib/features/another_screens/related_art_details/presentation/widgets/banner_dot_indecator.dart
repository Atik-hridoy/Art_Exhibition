import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/app_colors.dart';

Center BannerDotIndecator({required int selectIndex, int? maxdot}) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        maxdot ?? 3,
            (index) => Container(
          margin: const EdgeInsets.all(5),
          width: index == selectIndex ? 10.w : 10.h,
          height: 10.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: index == selectIndex
                ? AppColors.primaryColor
                : AppColors.white,
          ),
        ),
      ),
    ),
  );
}
