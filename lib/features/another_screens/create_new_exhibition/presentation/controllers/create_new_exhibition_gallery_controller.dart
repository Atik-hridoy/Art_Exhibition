// import 'package:get/get.dart';
// import 'package:tasaned_project/utils/helpers/other_helper.dart';

// class CreateNewExhibitionGalleryController extends GetxController {
//   final List<String> imagePaths = [];
//   String? videoPath;

//   int get photosCount => imagePaths.length;
//   static const int maxPhotos = 10;

//   Future<void> pickImages() async {
//     final remaining = maxPhotos - imagePaths.length;
//     if (remaining <= 0) return;
//     final picked = await OtherHelper.pickMultipleImage(imageLimit: remaining);
//     if (picked.isNotEmpty) {
//       imagePaths.addAll(picked);
//       update();
//     }
//   }

//   void removeImageAt(int i) {
//     if (i >= 0 && i < imagePaths.length) {
//       imagePaths.removeAt(i);
//       update();
//     }
//   }

//   void removeVideo() {
//     videoPath = null;
//     update();
//   }
// }
