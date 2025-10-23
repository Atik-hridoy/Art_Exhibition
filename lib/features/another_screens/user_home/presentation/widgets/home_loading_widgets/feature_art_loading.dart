import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/arts_item.dart';

class FeatureArtLoading extends StatelessWidget {
  const FeatureArtLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 182.h,
      child: ListView.separated(
        padding: EdgeInsets.only(right: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return ArtsItem(
            imageUrl: '',
            price: 6000,
            title: 'fedhdfghdxghdfghdegdh',
            isSaved: false,
            onTapSave: () async {},
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 16.w),
      ),
    );
  }
}
