import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/artist_details/presentation/controller/artist_details_controller.dart';
import 'package:tasaned_project/features/another_screens/artist_details/presentation/widgets/artist_about_us_section.dart';
import 'package:tasaned_project/features/another_screens/artist_details/presentation/widgets/artist_art_work_section.dart';
import 'package:tasaned_project/features/another_screens/artist_details/presentation/widgets/artist_details_heading_section.dart';
import 'package:tasaned_project/features/another_screens/artist_details/presentation/widgets/artist_event_section.dart';
import 'package:tasaned_project/features/another_screens/artist_details/presentation/widgets/artist_exhibition_section.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';

class ArtistDetailsScreen extends StatelessWidget {
  const ArtistDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final artistId = args != null ? args['artistId'] as String? ?? '' : '';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: AppBar(
          backgroundColor: AppColors.white,
          shadowColor: AppColors.transparent,
          surfaceTintColor: AppColors.transparent,
        ),
      ),

      body: GetBuilder<ArtistDetailsController>(
        init: ArtistDetailsController(artistId: artistId),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.artistDetails == null) {
            return const Center(child: Text('Artist details not available'));
          }

          final artist = controller.artistDetails!;

          return SingleChildScrollView(
            child: Column(
              children: [
                ArtistDetailsHeadingSection(
                  controller: controller,
                  artist: artist,
                ),

                controller.isTypeSelected == "aboutUS"
                    ? ArtistAboutUsSection(
                        about: artist.about,
                        keyAchievements: artist.keyAchievements,
                      )
                    : controller.isTypeSelected == "artWork"
                        ? ArtistArtWorkSection(arts: artist.arts)
                        : controller.isTypeSelected == "exhibition"
                            ? ArtistExhibitionSection(exhibitions: artist.exhibitions)
                            : controller.isTypeSelected == "event"
                                ? ArtistEventSection(events: artist.events)
                                : const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
