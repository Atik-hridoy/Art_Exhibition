import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../data/model/chat_list_model.dart';
import '../../../../utils/extensions/extension.dart';
import '../../../../utils/constants/app_colors.dart';

Widget chatListItem({required ChatModel item}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h, top: 12.h),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // Shadow color
          spreadRadius: 0, // Shadow spread
          blurRadius: 0.5, // Blur effect
          offset: Offset(0, 2), // Shadow position (horizontal, vertical)
        ),
      ],
      borderRadius: BorderRadius.circular(12.r),
      color: AppColors.white,
    ),
    child: Column(
      children: [
        Row(
          children: [
            /// participant image here
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: CommonImage(
                fill: BoxFit.fill,
                imageSrc: item.participant.image,
                size: 70,
              ),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// participant Name here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        right: 5,
                        text: item.participant.fullName,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      CommonText(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyClr,
                          text: "12:32 AM")
                    ],
                  ),
              
                  /// participant Last Message here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CommonText(
                          text: item.latestMessage.message,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
              
                      SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: PopupMenuButton<String>(
                          color: AppColors.white,
                          icon: Icon(Icons.more_vert, color: AppColors.textFiledColor),
              
                          onSelected: (value) {},
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: '',
                                child: CommonText(text:"Delete"),
                              ),
              
                            ];
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),




          ],
        ),
      ],
    ),
  );
}
