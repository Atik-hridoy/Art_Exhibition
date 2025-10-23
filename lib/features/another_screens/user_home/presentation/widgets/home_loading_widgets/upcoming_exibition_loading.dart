import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/exhibition_item.dart';

class UpcomingExibitionLoading extends StatelessWidget {
  const UpcomingExibitionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
        padding: EdgeInsets.only(right: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return ExhibitionItem(
            image: '',
            title: 'N/A',
            venue: 'N/A',
            isSaved: false,
            startDate: DateTime.now(),
            endDate: DateTime.now(),
            onTapSave: () {},
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 16.w),
      ),
    );
  }
}
