import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/component/text_field/common_text_field.dart';
import 'package:tasaned_project/features/another_screens/user_resel/presentation/controller/user_resell_controller.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class AllTextFiledSection extends StatelessWidget {
  const AllTextFiledSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UserReselController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CommonText(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                bottom: 8,
                text: AppString.artworkTitle),

            CommonTextField(
              hintText: AppString.enterArtworkTitle,
              borderColor: AppColors.stroke,
            ),

            16.height,

            CommonText(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                bottom: 8,
                text: AppString.category),

            CommonTextField(
              suffixIcon: Icon(
                  color: AppColors.bodyClr,
                  Icons.keyboard_arrow_down),
              hintText: AppString.selectCategory,
              borderColor: AppColors.stroke,
            ),


            16.height,

            CommonText(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                bottom: 8,
                text: AppString.description),

            CommonTextField(
              maxline: 3,

              hintText: AppString.describeYourArtwork,
              borderColor: AppColors.stroke,
            ),


            16.height,

            CommonText(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                bottom: 8,
                text: AppString.medium),

            CommonTextField(

              hintText: AppString.mediumHintText,
              borderColor: AppColors.stroke,
            ),


            16.height,

            CommonText(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                bottom: 8,
                text: AppString.dimensions),

            Row(
              children: [


                Expanded(
                  child: CommonTextField(

                    hintText: AppString.heightIn,
                    borderColor: AppColors.stroke,
                  ),
                ),

                17.width,


                Expanded(
                  child: CommonTextField(

                    hintText: AppString.widthIn,
                    borderColor: AppColors.stroke,
                  ),
                ),
              ],
            ),


            16.height,

            CommonText(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                bottom: 8,
                text: AppString.artist),

            CommonTextField(

              hintText: AppString.searchArtist,
              borderColor: AppColors.stroke,
            ),

            20.height,


            Row(
              children: [

                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    activeColor: AppColors.primaryColor,
                      value: controller.isCheckBox,
                      onChanged: (va){
                  controller.updateCheckBox();
                      }),
                ),
                
                CommonText(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.bodyClr,
                    left: 5,
                    text: "This Art work is not represented by any gallery")
              ],
            ),

            16.height,

            CommonText(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                bottom: 8,
                text: AppString.authentication),

            CommonTextField(
              suffixIcon: Icon(
                  color: AppColors.bodyClr,
                  Icons.keyboard_arrow_down),
              hintText: AppString.selectAuthentication,
              borderColor: AppColors.stroke,
            ),


            16.height,

            CommonText(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                bottom: 8,
                text: AppString.frame),
            
            Row(
              
              children: [
                
                CommonText(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    right: 30,
                    text: AppString.includeOriginalFrame),

                SizedBox(
                  height: 24.h,width: 24.w,
                  child: Switch(

                      activeThumbColor: AppColors.primaryColor,
                      value: controller.isFrameToggle, onChanged: (v){

                    controller.updateFrameToggle();
                  }),
                )
              ],
            ),


            16.height,

            CommonText(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                bottom: 8,
                text: AppString.price),

            CommonTextField(
              prefixIcon: Icon(Icons.monetization_on_sharp),
              
              hintText: AppString.price,
              borderColor: AppColors.stroke,
            ),

            16.height,

            Row(

              children: [

                CommonText(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    right: 30,
                    text: AppString.acceptOffersFromBuyers),

                SizedBox(
                  height: 24.h,width: 24.w,
                  child: Switch(

                      activeThumbColor: AppColors.primaryColor,
                      value: controller.isAcceptToggle, onChanged: (v){

                    controller.updateAcceptToggle();
                  }),
                )
              ],
            ),

            20.height,
            
            CommonButton(

                buttonRadius: 60,
                titleText: AppString.listArtwork)

            ,

            20.height,



          ],
        );
      }
    );
  }
}
