import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class PopularArtistItem extends StatelessWidget {
  final String name;
  final String profileImage;
  final int followers;
  const PopularArtistItem({
    super.key,
    required this.name,
    required this.profileImage,
    required this.followers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: CommonImage(
            height: 60,
            width: 60,
            fill: BoxFit.cover,
            imageSrc: ApiEndPoint.imageUrl + profileImage, // AppImages.female
          ),
        ),

        6.height,

        CommonText(
          fontSize: 12,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          text: name,
        ), // "John Henry"),

        3.height,

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.group_outlined, size: 14.sp, color: AppColors.bodyClr),

            4.width,

            CommonText(
              text: followers.toString(), // "1.2k Followers",
              fontSize: 10,
              color: AppColors.bodyClr,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ],
    );
  }
}
