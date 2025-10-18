// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:tasaned_project/component/button/common_button.dart';
// import 'package:tasaned_project/component/text/common_text.dart';
// import 'package:tasaned_project/features/another_screens/exhibition/presentation/controller/exhibition_controller.dart';
// import 'package:tasaned_project/features/another_screens/exhibition/presentation/widgets/art_work_section.dart';
// import 'package:tasaned_project/features/another_screens/exhibition/presentation/widgets/overview_section.dart';
// import 'package:tasaned_project/utils/constants/app_colors.dart';
// import 'package:tasaned_project/utils/constants/app_string.dart';
// import 'package:tasaned_project/utils/extensions/extension.dart';
// import '../widgets/exhibition_heading_section.dart';

// class ExhibitionScreen extends StatelessWidget {
//   const ExhibitionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         shadowColor: AppColors.transparent,
//         surfaceTintColor: AppColors.transparent,
//         backgroundColor: AppColors.background,
//         title: CommonText(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//           color: AppColors.titleColor,

//           text: AppString.exhibitionDetails,
//         ),
//         leading: InkWell(
//           onTap: () {
//             Get.back();
//           },
//           child: Icon(
//             Icons.arrow_back_ios,
//             size: 24.sp,
//             color: AppColors.titleColor,
//           ),
//         ),
//       ),

//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: GetBuilder(
//             init: ExhibitionController(),
//             builder: (controller) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ExhibitionHeadingSection(),
//                   controller.isSelectedType == "Overview"
//                       ? OverviewSection()
//                       : ArtWorkSection(),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),

//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20.r),
//               topRight: Radius.circular(20.r)),
//           border: Border(top: BorderSide(color: AppColors.stroke)),
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
//         height: 160.h,
//         child: Column(
//           children: [
//             CommonButton(titleText: AppString.getTickets),
//             16.height,
//             CommonButton(
//                 titleColor: AppColors.titleColor,
//                 borderColor:AppColors.stroke,
//                 buttonColor: AppColors.transparent,
//                 titleText: AppString.addToFavourite),
//           ],
//         ),
//       ),
//     );
//   }
// }
