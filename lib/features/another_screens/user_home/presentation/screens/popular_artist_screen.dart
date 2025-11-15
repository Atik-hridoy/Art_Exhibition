import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/controllers/home_controller.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/widgets/popular_artist_item.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';


class PopularArtistScreen extends StatelessWidget {
  const PopularArtistScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController()..popuparArtist(),
      builder: (controller) {
        final artists = controller.popularArtistList;
        final isLoading = controller.populartArtistIsLoading;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.background,
            shadowColor: AppColors.transparent,
            surfaceTintColor: AppColors.transparent,
            title: CommonText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
              text: AppString.popularArtist,
            ),
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 23.sp,
                color: AppColors.titleColor,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : (artists == null || artists.isEmpty)
                    ? Center(
                        child: CommonText(
                          text: AppString.noPopularArtist,
                          color: AppColors.bodyClr,
                        ),
                      )
                    : GridView.builder(
                        itemCount: artists.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 16.h,
                        ),
                        itemBuilder: (context, index) {
                          final artist = artists[index];
                          return InkWell(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.artistDetailsScreen,
                                arguments: {'artistId': artist.id},
                              );
                            },
                            child: PopularArtistItem(
                              name: artist.name,
                              profileImage: artist.profileImage ?? '',
                              followers: artist.followers,
                            ),
                          );
                        },
                      ),
          ),
        );
      },
    );
  }
}
