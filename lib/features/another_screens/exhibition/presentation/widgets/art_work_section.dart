
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/arts_item.dart';
// import '../../../../../config/route/app_routes.dart';

// class ArtWorkSection extends StatelessWidget {
//   const ArtWorkSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:  EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
//       child: GridView.builder(


//           itemCount: 10,
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,  // Number of columns
//               crossAxisSpacing: 1, // Horizontal space between items
//               mainAxisSpacing:20 ,
//               mainAxisExtent: 180.h
//             // Vertical space between items
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
