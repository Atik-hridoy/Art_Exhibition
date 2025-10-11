import 'package:get/get.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/enum/enum.dart';

class FollowersController extends GetxController {
  final List<Map<String, String>> followers = [
    {"name": "Robert Fox", "role": Role.artist.role, "image": AppImages.female},
    {"name": "Courtney Henry", "role": Role.artist.role, "image": AppImages.female},
    {"name": "Jenny Wilson", "role": Role.artist.role, "image": AppImages.female},
    {
      "name": "Cameron Williamson",
      "role": Role.collector.role,
      "image": AppImages.female,
    },
    {"name": "Dianne Russell", "role": Role.collector.role, "image": AppImages.female},
    {"name": "Darrell Steward", "role": Role.artist.role, "image": AppImages.female},
    {"name": "Arlene McCoy", "role": Role.collector.role, "image": AppImages.female},
    {"name": "Leslie Alexander", "role": Role.collector.role, "image": AppImages.female},
  ];
}
