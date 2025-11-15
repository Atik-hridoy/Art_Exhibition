import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/data_model/artist_details_model.dart';
import 'artist_item_details.dart';

class ArtistArtWorkSection extends StatelessWidget {
  final List<ArtistArtItem> arts;
  const ArtistArtWorkSection({super.key, required this.arts});

  @override
  Widget build(BuildContext context) {
    if (arts.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: const Text('No artworks available.'),
      );
    }

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: GridView.builder(
          itemCount: arts.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing:20,
            mainAxisExtent: 190.h
          ), itemBuilder: (context, index){
        final art = arts[index];
        return InkWell(
            onTap: (){
              Get.toNamed(AppRoutes.artDetailsScreen, arguments: {'artId': art.id});
            },
            child: ArtistItemDetails(
              imagePath: art.image,
              title: art.title,
              price: art.price,
            ));
      }),
    );
  }
}
