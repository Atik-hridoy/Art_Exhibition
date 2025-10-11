import 'package:get/get.dart';
import 'package:tasaned_project/utils/enum/enum.dart';

class ChooseRoleController extends GetxController {
  // 0: Visitor, 1: Artist, 2: Collector, 3: Curator, 4: Museum, 5: Educational Institution
  RxInt selectedIndex = 0.obs;

  void select(int index) {
    selectedIndex.value = index;
    update();
  }

  String get selectedRoleKey {
    switch (selectedIndex.value) {
      case 0:
        return Role.user.role;
      case 1:
        return Role.artist.role;
      case 2:
        return Role.collector.role;
      case 3:
        return Role.curator.role;
      case 4:
        return Role.museum.role;
      case 5:
        return Role.educational.role;
      default:
        return Role.user.role;
    }
  }
}
