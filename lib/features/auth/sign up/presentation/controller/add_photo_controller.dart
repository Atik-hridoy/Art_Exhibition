import 'package:get/get.dart';

import '../../../../../utils/helpers/other_helper.dart';

class AddPhotoController extends GetxController {
  String? image;

  /// select image function here
  getProfileImage() async {
    image = await OtherHelper.openGallery();
    update();
  }
}
