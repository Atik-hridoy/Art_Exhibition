import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/popular_artist_item.dart';

class PopularArtistLoading extends StatelessWidget {
  const PopularArtistLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        padding: EdgeInsets.only(right: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return PopularArtistItem(name: 'N/A', profileImage: 'N/A', followers: 0);
        },
        separatorBuilder: (_, __) => SizedBox(width: 16.w),
      ),
    );
  }
}
