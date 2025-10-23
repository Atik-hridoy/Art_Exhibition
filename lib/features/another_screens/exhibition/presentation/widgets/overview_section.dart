
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tasaned_project/component/image/common_image.dart';
// import 'package:tasaned_project/component/text/common_text.dart';
// import 'package:tasaned_project/utils/constants/app_colors.dart';
// import 'package:tasaned_project/utils/constants/app_images.dart';
// import 'package:tasaned_project/utils/constants/app_string.dart';
// import 'package:tasaned_project/utils/extensions/extension.dart';

// import '../../../user_home/presentation/widgets/popular_artist_item.dart';

// class OverviewSection extends StatelessWidget {
//   const OverviewSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [

//         16.height,
//         Container(
//           padding: EdgeInsets.all(16.r),
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(color: AppColors.stroke)
//           ),

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,

//             children: [
//               CommonText(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   text: AppString.aboutTheExhibition),
              
//               CommonText(
//                 top: 6,
//                   color: AppColors.bodyClr,
//                   maxLines: 4,
//                   fontSize: 12,
//                   textAlign: TextAlign.start,
//                   fontWeight: FontWeight.w400,

//                   text: "Immerse yourself in a captivating collection of contemporary abstract artworks that challenge perception and ignite imagination. Features 30+ pieces from renowned international artists.")
//             ],
//           ),
//         ),

//         20.height,


//         Container(
//           padding: EdgeInsets.all(16.r),
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(color: AppColors.stroke)
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CommonText(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   bottom: 12,
//                   text: AppString.exhibitionDetails),

//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(Icons.calendar_month),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [

//                       CommonText(
//                           fontSize: 14,
//                           left: 6,
//                           fontWeight: FontWeight.w600,
//                           text: "${AppString.duration}: "),

//                       CommonText(
//                           fontSize: 14,
//                           left: 6,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.bodyClr,
//                           text: "15 July 25 - 30 July 25"),


//                       CommonText(
//                           fontSize: 14,
//                           left: 6,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.green,
//                           text: "4 Days Remaining"),
//                     ],
//                   )
//                 ],
//               ),

//               12.height,


//             Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(Icons.watch_later_outlined),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [

//                       CommonText(
//                           fontSize: 14,
//                           left: 6,
//                           fontWeight: FontWeight.w600,
//                           text: "${AppString.visitingHour} "),

//                       CommonText(
//                           fontSize: 14,
//                           left: 6,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.bodyClr,
//                           text: "10:00 am - 6:00 pm (Monday Closed)"),



//                     ],
//                   )
//                 ],
//               ),



//               12.height,


//             Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(Icons.watch_later_outlined),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [

//                       CommonText(
//                           fontSize: 14,
//                           left: 6,
//                           fontWeight: FontWeight.w600,
//                           text: "${AppString.venue} "),

//                       CommonText(
//                           fontSize: 14,
//                           left: 6,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.bodyClr,
//                           text: "The Art Collective Gallery, New York"),


//                       CommonText(
//                           fontSize: 14,
//                           left: 6,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.primaryColor,
//                           text: "View on Map"),



//                     ],
//                   )
//                 ],
//               ),


//               12.height,


//             Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(Icons.airplane_ticket_outlined),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [

//                       CommonText(
//                           fontSize: 14,
//                           left: 6,
//                           fontWeight: FontWeight.w600,
//                           text: "${AppString.tickerPrice} "),

//                       CommonText(
//                           fontSize: 14,
//                           left: 6,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.bodyClr,
//                           text: "General : 18\$ "),

//                       CommonText(
//                           fontSize: 14,
//                           left: 6,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.bodyClr,
//                           text: "Students : 10\$"),

//                       CommonText(
//                           fontSize: 14,
//                           left: 6,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.bodyClr,
//                           text: "Members : Free"),





//                     ],
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),

//         20.height,

//         Container(
//           padding: EdgeInsets.all(16.r),
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(
//               color: AppColors.stroke
//             ),
//           ),
//           child: Column(
//             children: [

//               Row(
//                 children: [
//                   ClipOval(child: CommonImage(
//                       height: 42,
//                       width: 40,
//                       fill: BoxFit.fill,
//                       imageSrc: AppImages.female)),

//                   6.width,

//                   Column(
//                     children: [
//                       CommonText(
//                           color: AppColors.bodyClr,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           text: "Gallery / Museum")  ,

//                       CommonText(
//                           color: AppColors.titleColor,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           text: "The Art Gallery "),

//                     ],
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),

//         20.height,
        
//         CommonText(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: AppColors.titleColor,
//             bottom: 8,
//             text: AppString.featureArts).start,

//         SizedBox(
//           height: 90.h,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: 5,
//             itemBuilder: (context, index) {
//               return PopularArtistItem();
//             },
//           ),
//         ),


//         50.height



//       ],
//     );
//   }
// }
