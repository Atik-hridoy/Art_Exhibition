// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:tasaned_project/component/button/common_button.dart';
// import 'package:tasaned_project/component/image/common_image.dart';
// import 'package:tasaned_project/component/text/common_text.dart';
// import 'package:tasaned_project/component/text_field/common_text_field.dart';
// import 'package:tasaned_project/utils/constants/app_colors.dart';
// import 'package:tasaned_project/utils/constants/app_string.dart';
// import 'package:tasaned_project/utils/extensions/extension.dart';
// import 'package:tasaned_project/config/route/app_routes.dart';
// import '../controllers/create_new_exhibition_feature_artist_controller.dart';

// class CreateNewExhibitionFeatureArtistScreen extends StatelessWidget {
//    CreateNewExhibitionFeatureArtistScreen({super.key});
//    final String title = Get.arguments["title"];

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CreateNewExhibitionFeatureArtistController>(
//       init: CreateNewExhibitionFeatureArtistController(),
//       builder: (c) {
//         return Scaffold(
//           backgroundColor: AppColors.background,
//           appBar: AppBar(
//             backgroundColor: AppColors.white,
//             shadowColor: AppColors.transparent,
//             surfaceTintColor: AppColors.transparent,
//             leading: InkWell(
//               onTap: () => Get.back(),
//               child: Icon(Icons.arrow_back_ios, size: 22.sp, color: AppColors.titleColor),
//             ),
//             title: CommonText(
//               text: title=="Edit Exhibition"? AppString.editExhibition: AppString.createExhibition,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: AppColors.titleColor,
//             ),
          
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CommonText(
//                         text: 'Feature Artist',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.titleColor,
//                       ),
//                       12.height,
//                       Row(
//                         children: [
//                           _stepBar(active: true),
//                           6.width,
//                           _stepBar(active: true),
//                           6.width,
//                           _stepBar(active: true),
//                           6.width,
//                           _stepBar(active: false),
//                         ],
//                       ),
                
//                       20.height,
//                       CommonText(
//                         text: 'Add Artists',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.titleColor,
//                       ),
//                       8.height,
                
//                       CommonTextField(
//                         hintText: AppString.searchArtist,
//                         fillColor: AppColors.white,
//                         borderColor: AppColors.stroke,
//                         prefixIcon: Icon(Icons.search, color: AppColors.normalGray2),
//                         onSubmitted: (v) => c.onSearchChanged(v),
//                         // also respond to typing via a controllerless onChanged: use suffixIcon with Gesture? keep simple: use onSubmitted for demo
//                       ),
                
//                       12.height,
//                       // Artist list
//                       ListView.separated(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: c.visibleArtists.length,
//                         separatorBuilder: (_, __) => 10.height,
//                         itemBuilder: (_, i) {
//                           final item = c.visibleArtists[i];
//                           final selected = c.isSelected(item);
//                           return Container(
//                             padding: EdgeInsets.all(10.w),
//                             decoration: BoxDecoration(
//                               color: AppColors.white,
//                               borderRadius: BorderRadius.circular(10.r),
//                               border: Border.all(color: AppColors.stroke),
//                             ),
//                             child: Row(
//                               children: [
//                                 CommonImage(
//                                   imageSrc: item.image,
//                                   height: 40.w,
//                                   width: 40.w,
//                                   borderRadius: 8.r,
//                                   fill: BoxFit.cover,
//                                 ),
//                                 12.width,
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       CommonText(
//                                         text: item.name,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                         color: AppColors.titleColor,
//                                         textAlign: TextAlign.left,
//                                       ),
//                                       4.height,
//                                       Row(
//                                         children: [
//                                           Icon(Icons.account_circle_outlined, size: 14.sp, color: AppColors.bodyClr),
//                                           6.width,
//                                           CommonText(
//                                             text: '${item.role}  |  ${item.followersText}',
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w400,
//                                             color: AppColors.bodyClr,
//                                             textAlign: TextAlign.left,
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () => c.toggleSelection(item),
//                                   child: Container(
//                                     height: 18.w,
//                                     width: 18.w,
//                                     decoration: BoxDecoration(
//                                       color: selected ? AppColors.primaryColor : AppColors.primaryColor,
//                                       borderRadius: BorderRadius.circular(2.r),
//                                     ),
//                                     child: Icon(
//                                       selected ? Icons.check : Icons.add,
//                                       color: AppColors.white,
//                                       size: 12.sp,
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       ),
                
//                       if(c.selected.isEmpty)
                
//                       80.height,
                 
                
//                     ],
//                   ),
//                 ),
            
            
            
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 20.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20.r),
//                         topRight: Radius.circular(20.r),
//                       ),
//                       border: Border(
//                         top: BorderSide(
//                           color: AppColors.stroke,width: 1
//                         ),
//                       ),
//                     ),
//                     child: Column(children: [
//                             if(c.selected.isEmpty)

//                   20.height,
//                               if (c.selected.isNotEmpty) ...[
//                     Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.all(12.w),
//                       decoration: BoxDecoration(
//                         color: AppColors.white,
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CommonText(
//                             text: 'Selected Artist',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.titleColor,
//                             textAlign: TextAlign.left,
//                           ),
//                           12.height,
//                           ListView.separated(
//                             physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: c.selected.length,
//                             separatorBuilder: (_, __) => 10.height,
//                             itemBuilder: (_, i) {
//                               final sel = c.selected[i];
//                               return Container(
//                                 padding: EdgeInsets.all(10.w),
//                                 decoration: BoxDecoration(
//                                   color: AppColors.white,
//                                   borderRadius: BorderRadius.circular(12.r),
//                                   border: Border.all(color: AppColors.stroke),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     CommonImage(
//                                       imageSrc: sel.image,
//                                       height: 44.w,
//                                       width: 44.w,
//                                       borderRadius: 8.r,
//                                       fill: BoxFit.cover,
//                                     ),
//                                     12.width,
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           CommonText(
//                                             text: sel.name,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: AppColors.titleColor,
//                                             textAlign: TextAlign.left,
//                                           ),
//                                           4.height,
//                                           Row(
//                                             children: [
//                                               Icon(Icons.account_circle_outlined, size: 14.sp, color: AppColors.bodyClr),
//                                               6.width,
//                                               CommonText(
//                                                 text: '${sel.role}  |  ${sel.followersText}',
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: AppColors.bodyClr,
//                                                 textAlign: TextAlign.left,
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     InkWell(
//                                       onTap: () => c.removeSelection(sel),
//                                       child: Container(
//                                         height: 18.w,
//                                         width: 18.w,
//                                         decoration: BoxDecoration(
//                                           color: const Color(0xFFE74C3C),
//                                           borderRadius: BorderRadius.circular(6.r),
//                                         ),
//                                         child: Icon(
//                                           Icons.close,
//                                           color: AppColors.white,
//                                           size: 12.sp,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],

               


                   
//                     CommonButton(
//                       buttonRadius: 60,
//                       titleColor: AppColors.primaryColor,
//                       borderColor: AppColors.primaryColor,
//                       buttonColor: AppColors.white,
//                       titleText: AppString.saveAsDraft,
//                       onTap: () {},
//                     ),
//                     12.height,
//                     CommonButton(
//                       titleText: 'Next',
//                       buttonRadius: 60,
//                       onTap: () {
//                         Get.toNamed(AppRoutes.createNewExhibitionTicketBookingScreen,
//                         arguments: {
//                           "title": title=="Edit Exhibition"? "Edit Exhibition": "Create New Exhibition"
//                         });
//                       },
//                     ),
//                     20.height,
//                     ],),
//                   )

             
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _stepBar({required bool active}) {
//     return Expanded(
//       child: Container(
//         height: 6.h,
//         decoration: BoxDecoration(
//           color: active ? AppColors.primaryColor : AppColors.normalGray,
//           borderRadius: BorderRadius.circular(100.r),
//         ),
//       ),
//     );
//   }
// }
