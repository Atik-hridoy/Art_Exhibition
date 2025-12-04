import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class ResaleInfoCard extends StatelessWidget {
  const ResaleInfoCard({super.key, required this.originalPrice});
  final String originalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.yelloFade,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.info, color: AppColors.primaryColor, size: 18.sp),
              5.width,
               CommonText(
                
              
              color: AppColors.titleColor,
                fontSize: 12,
                text: AppString.resaleInformation, fontWeight: FontWeight.w600),
            ],
          ),
       6.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
                left: 20,
             
                text: '15 Aug, 2025', fontSize: 14),
                CommonText(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                     right: 20,
                  text: '\$$originalPrice', fontSize: 14),
            ],
          ),

          4.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            
            CommonText(
                    left: 20,
             
              color: AppColors.titleColor,
              fontWeight: FontWeight.w400,
           
              text: 'Previous Purchase', fontSize: 12),
              const SizedBox(height: 2),
              const CommonText
              
              (
                fontWeight: FontWeight.w400,
                color: AppColors.titleColor,
                text: AppString.originalPrice, fontSize: 12),
            ],
          )
        ],
      ),
    );
  }
}
