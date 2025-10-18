// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../../../config/route/app_routes.dart';
// import '../../../user_home/presentation/widgets/arts_item.dart';

// class ArtWorkSection extends StatelessWidget {
//   const ArtWorkSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//       child: GridView.builder(

//           itemCount: 10,
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,  // Number of columns
//             crossAxisSpacing: 1, // Horizontal space between items
//             mainAxisSpacing:20 , // Vertical space between items
//           ), itemBuilder: (context, index){

//         return InkWell(

//             onTap: (){
//               Get.toNamed(AppRoutes.artDetailsScreen);
//             },
//             child: ArtsItem());
//       }),
//     );
//   }
// }
