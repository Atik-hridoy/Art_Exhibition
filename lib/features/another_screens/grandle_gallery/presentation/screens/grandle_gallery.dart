// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tasaned_project/utils/constants/app_colors.dart';

// import '../controller/controller/artist_details_controller.dart';
// import '../widgets/about_us_section.dart';
// import '../widgets/art_work_section.dart';
// import '../widgets/heading_section.dart';
// import '../widgets/shows_section.dart';

// class GrandleGallery extends StatelessWidget {
//   const GrandleGallery({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size(0, 0),
//         child: AppBar(
//           backgroundColor: AppColors.white,
//           shadowColor: AppColors.transparent,
//           surfaceTintColor: AppColors.transparent,
//         ),
//       ),
      
//       body: GetBuilder(
//         init: ArtistDetailsController(),
//         builder: (controller) {
//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 HeadingSection(),
            
//                 controller.isTypeSelected=="aboutUS"?AboutUsSection():controller.isTypeSelected=="artWork"?ArtWorkSection():ShowsSection()
            
            
            
//               ],
//             ),
//           );
//         }
//       ),
//     ) ;
//   }
// }
