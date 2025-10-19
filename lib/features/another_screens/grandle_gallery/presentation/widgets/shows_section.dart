// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../user_home/presentation/widgets/exhibition_item.dart';

// class ShowsSection extends StatelessWidget {
//   const ShowsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical:
//       20.h),
//       child: GridView.builder(

//           itemCount: 20,
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,  // Number of columns
//               crossAxisSpacing: 1, // Horizontal space between items
//               mainAxisSpacing:20 ,

//               mainAxisExtent: 190.h
//             // Vertical space between items
//           ), itemBuilder: (context, index){

//         return ExhibitionItem();
//       }),
//     );
//   }
// }
