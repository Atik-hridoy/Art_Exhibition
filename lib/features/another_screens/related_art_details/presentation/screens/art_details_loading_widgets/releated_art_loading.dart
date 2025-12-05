import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/arts_item.dart';

class ReleatedArtLoading extends StatelessWidget {
  const ReleatedArtLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 182.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ArtsItem(
              imageUrl: '',
              price: 6000,
              title: 'title',
              isSaved: false,
              onTapSave: () async {},
            ),
          );
        },
      ),
    );
  }
}
