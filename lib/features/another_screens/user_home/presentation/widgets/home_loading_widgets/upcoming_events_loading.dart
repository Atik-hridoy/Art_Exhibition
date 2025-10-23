import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/event_item.dart';

class UpcomingEventsLoading extends StatelessWidget {
  const UpcomingEventsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
        padding: EdgeInsets.only(right: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return EventItem(
            cover: '',
            title: 'edyrjftjtghjfgjfgj',
            date: 'rtfy',
            month: 'reyrdtyr',
            venue: 'fgjtgfjghgiu',
            isSaved: false,
            onTapSave: () async {},
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 16.w),
      ),
    );
  }
}
