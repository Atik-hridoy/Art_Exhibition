import 'package:get/get.dart';
import 'package:tasaned_project/services/storage/storage_keys.dart';
import 'package:tasaned_project/services/storage/storage_services.dart';
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
        LocalStorage.setString(LocalStorageKeys.myRoll, Role.user.role);
        return Role.user.role;
      case 1:
        LocalStorage.setString(LocalStorageKeys.myRoll, Role.artist.role);
        return Role.artist.role;
      case 2:
        LocalStorage.setString(LocalStorageKeys.myRoll, Role.collector.role);
        return Role.collector.role;
      case 3:
        LocalStorage.setString(LocalStorageKeys.myRoll, Role.curator.role);
        return Role.curator.role;
      case 4:
        LocalStorage.setString(LocalStorageKeys.myRoll, Role.museum.role);
        return Role.museum.role;
      case 5:
        LocalStorage.setString(LocalStorageKeys.myRoll, Role.educational.role);
        return Role.educational.role;
      default:
        LocalStorage.setString(LocalStorageKeys.myRoll, Role.user.role);
        return Role.user.role;
    }
  }
}
