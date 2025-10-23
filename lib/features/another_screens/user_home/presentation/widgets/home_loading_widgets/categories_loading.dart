import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/category_item.dart';

class CategoriesLoading extends StatelessWidget {
  const CategoriesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      child: ListView.separated(
        padding: EdgeInsets.only(right: 8.w),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return CategoryItem(title: 'N/A', imageSrc: '');
        },
        separatorBuilder: (_, __) => SizedBox(width: 6.w),
      ),
    );
  }
}
