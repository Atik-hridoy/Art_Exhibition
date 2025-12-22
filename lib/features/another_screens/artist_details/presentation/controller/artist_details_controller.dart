import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/features/data_model/artist_details_model.dart';
import 'package:tasaned_project/utils/app_utils.dart';

class ArtistDetailsController extends GetxController {
  final String artistId;

  ArtistDetailsController({required this.artistId});

  String isTypeSelected = "aboutUS";
  bool isFollowing = false;
  bool isLoading = false;
  ArtistDetailsModel? artistDetails;

  @override
  void onInit() {
    super.onInit();
    if (artistId.isNotEmpty) {
      fetchArtistDetails();
    }
  }

  Future<void> fetchArtistDetails() async {
    try {
      isLoading = true;
      update();

      final response = await getArtistDetails(artistId);
      if (response != null) {
        artistDetails = response;
        isFollowing = response.isFollowing;
      } else {
        Utils.errorSnackBar('Error', 'Failed to load artist details');
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Something went wrong: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void updateType({required String type}) {
    isTypeSelected = type;
    update();
  }

  Future<void> toggleFollowing() async {
    try {
      isFollowing = !isFollowing;
      update();

      // Call API to follow/unfollow
      if (isFollowing) {
        final response = await followArtist(artistId);
        if (response != null && response.statusCode == 200) {
          Utils.successSnackBar('Success', 'Artist followed');
        } else {
          // Revert if API call fails
          isFollowing = !isFollowing;
          Utils.errorSnackBar('Error', 'Failed to follow artist');
        }
      } else {
        final response = await unfollowArtist(artistId);
        if (response != null && response.statusCode == 200) {
          Utils.successSnackBar('Success', 'Artist unfollowed');
        } else {
          // Revert if API call fails
          isFollowing = !isFollowing;
          Utils.errorSnackBar('Error', 'Failed to unfollow artist');
        }
      }
      update();
    } catch (e) {
      isFollowing = !isFollowing;
      Utils.errorSnackBar('Error', 'Something went wrong: $e');
      update();
    }
  }
}
