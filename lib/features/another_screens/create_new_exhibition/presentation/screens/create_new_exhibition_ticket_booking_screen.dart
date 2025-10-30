// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:tasaned_project/component/button/common_button.dart';
// import 'package:tasaned_project/component/text/common_text.dart';
// import 'package:tasaned_project/component/text_field/common_text_field.dart';
// import 'package:tasaned_project/utils/constants/app_colors.dart';
// import 'package:tasaned_project/utils/constants/app_string.dart';
// import 'package:tasaned_project/utils/extensions/extension.dart';
// import 'package:tasaned_project/component/pop_up/create_exhibition_success_popup.dart';
// import '../controllers/create_new_exhibition_ticket_booking_controller.dart';

// class CreateNewExhibitionTicketBookingScreen extends StatelessWidget {
//    CreateNewExhibitionTicketBookingScreen({super.key});
//    final String title = Get.arguments["title"];

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CreateNewExhibitionTicketBookingController>(
//       init: CreateNewExhibitionTicketBookingController(),
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
//           body: SizedBox(
//             height: Get.size.height,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w, ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CommonText(
//                         text: 'Ticket & Booking',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.titleColor,
//                       ),
//                       8.height,
//                       Row(
//                         children: [
//                           _stepBar(active: false),
//                           6.width,
//                           _stepBar(active: false),
//                           6.width,
//                           _stepBar(active: false),
//                           6.width,
//                           _stepBar(active: true),
//                         ],
//                       ),
            
//                       20.height,
//                       CommonText(
//                         text: 'Ticket Price',
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.titleColor,
//                         textAlign: TextAlign.left,
//                       ),
//                       8.height,
//                       CommonTextField(
//                         hintText: 'Enter Amount',
//                         prefixText: '	',
//                         prefixIcon: Icon(Icons.attach_money, color: AppColors.normalGray2),
//                         keyboardType: TextInputType.number,
//                         controller: c.priceController,
//                         borderColor: AppColors.stroke,
//                         fillColor: AppColors.white,
//                       ),
            
//                       16.height,
//                       CommonText(
//                         text: 'Booking URL',
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.titleColor,
//                         textAlign: TextAlign.left,
//                       ),
//                       8.height,
//                       CommonTextField(
//                         hintText: 'Enter booking URL',
//                         controller: c.urlController,
//                         borderColor: AppColors.stroke,
//                         fillColor: AppColors.white,
//                         keyboardType: TextInputType.url,
//                       ),
//                     ],
//                   ),
//                 ),
            
//                        Spacer(),
            
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20.r),
//                       topRight: Radius.circular(20.r),
//                     ),
//                     border: Border(
//                       top: BorderSide(
//                         color: AppColors.stroke,
//                       ),
//                     ),
//                   ),
//                   child: Column(
//                     children: [

//                       20.height,
//                       CommonButton(
//                         buttonRadius: 60,
//                         titleColor: AppColors.primaryColor,
//                         borderColor: AppColors.primaryColor,
//                         buttonColor: AppColors.white,
//                         titleText: AppString.saveAsDraft,
//                         onTap: () {},
//                       ),
//                       12.height,
//                       CommonButton(
//                         titleText: 'Publish',
//                         buttonRadius: 60,
//                         onTap: () {
//                           CreateNewExhibitionSuccessPopup2.show();
//                         },
//                       ),

//                       30.height
//                     ],
//                   ),
//                 ),
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
