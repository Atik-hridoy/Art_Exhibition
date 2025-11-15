
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

import '../../../../../component/text/common_text.dart';

class ArtistAboutUsSection extends StatelessWidget {
  final String about;
  final String keyAchievements;
  const ArtistAboutUsSection({super.key, required this.about, required this.keyAchievements});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          16.height,
CommonText(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.titleColor,
    text: AppString.biography),

          16.height,
          CommonText(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.bodyClr,
              textAlign: TextAlign.start,
              bottom: 32,
              text: about.isNotEmpty
                  ? about
                  : "Biography information will be available soon."),


          CommonText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
              text: AppString.keyAchievements).start,



          16.height,

          customItem(
            title: keyAchievements.isNotEmpty
                ? keyAchievements
                : "Key achievements will be added soon.",
          ),

        ],
      ),
    );
  }

  Widget customItem({title}){
    return   Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding:  EdgeInsets.only(top: 5.h),
          child: customPoint(),
        ),

        Flexible(
          child: CommonText(
              color: AppColors.bodyClr,
              fontSize: 14,
              left: 5,
              textAlign: TextAlign.start,
              maxLines: 2,
              fontWeight: FontWeight.w400,
              text: title),
        )
      ],
    );
  }

  Widget customPoint(){
    return  Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(

              color: AppColors.bodyClr)
      ),
      child: Container(
        height: 3.h,
        width: 3.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.bodyClr
        ),
      ),
    );
  }
}
