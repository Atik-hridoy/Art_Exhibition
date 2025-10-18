import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/artist_details/presentation/widgets/artist_details_heading_section.dart';
import 'package:tasaned_project/features/another_screens/artist_details/presentation/widgets/artist_event_section.dart';
import 'package:tasaned_project/features/another_screens/artist_details/presentation/widgets/artist_exhibition_section.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import '../../../grandle_gallery/presentation/controller/controller/artist_details_controller.dart';
import '../widgets/artist_about_us_section.dart';
import '../widgets/artist_art_work_section.dart';

class ArtistDetailsScreen extends StatelessWidget {
  const ArtistDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: AppBar(
          backgroundColor: AppColors.white,
          shadowColor: AppColors.transparent,
          surfaceTintColor: AppColors.transparent,
        ),
      ),

      body: GetBuilder(
        init: ArtistDetailsController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ArtistDetailsHeadingSection(),

                controller.isTypeSelected == "aboutUS"
                    ? const ArtistAboutUsSection()
                    : controller.isTypeSelected == "artWork"
                    ? const ArtistArtWorkSection()
                    : controller.isTypeSelected == "exhibition"
                    ? const ArtistExhibitionSection()
                    : controller.isTypeSelected == "event"
                    ? const ArtistEventSection()
                    : const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
