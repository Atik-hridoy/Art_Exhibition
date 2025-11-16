import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/features/data_model/learning_material_model.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class LearningOverviewSection extends StatelessWidget {
  final LearningMaterialModel detail;

  const LearningOverviewSection({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    final description = detail.description.isNotEmpty
        ? detail.description
        : "A concise explanation of the lesson’s content: \n“In this first week, we’ll introduce you to acrylic painting. Learn about essential materials like acrylic paints, brushes, and canvases.”";
    final learningPoints = detail.tutorials.isNotEmpty
        ? detail.tutorials.map((e) => e.title).where((title) => title.isNotEmpty).toList()
        : [
            "Understand acrylic painting materials: Get to know the different types of brushes, paints, and canvases used in acrylic painting.",
            "Brush Techniques: Learn dry brushing and wet blending techniques to create smooth, blended transitions in your work.",
            "Complete your first project: Create a gradient background using the techniques learned in this lesson."
          ];

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CommonText(
              maxLines: 10,
              color: AppColors.bodyClr,
              bottom: 11,
              textAlign: TextAlign.justify,
              text: description),
          
          
          CommonText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
              text: AppString.learningObjectives),


          CommonText(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.bodyClr,
              text: AppString.keyPointsLearnInThisLesson),

          Padding(
            padding:  EdgeInsets.only(left: 20.w),
            child: Column(

              children: [
                for (var i = 0; i < learningPoints.length; i++) ...[
                  if (i == 0) 5.height else 10.height,
                  pointItem(title: learningPoints[i]),
                ],
                30.height

              ],
            ),
          )        ],
      ),


    );
  }

  Widget pointItem({required String title}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start
      ,
      children: [

        Padding(
          padding:  EdgeInsets.only(top: 10.h),
          child: customPoint(),
        ),

        Expanded(
          child: CommonText(
              fontSize: 14,
              left: 7,
              maxLines: 5,
              fontWeight: FontWeight.w400,
              color: AppColors.bodyClr,
              textAlign: TextAlign.start,
              text: title),
        )
      ],
    );
  }

  Widget customPoint(){
    return Container(
      height: 5,
      width: 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.bodyClr
      ),
    );
  }
}
