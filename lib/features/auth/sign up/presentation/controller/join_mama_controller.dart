import 'package:get/get.dart';

import '../../../../../services/storage/storage_keys.dart';
import '../../../../../services/storage/storage_services.dart';

class JoinMamaController extends GetxController {
  int selectedSignUpButtonIndex = 0;

  updateSignUpSelectedButton(int index) {
    selectedSignUpButtonIndex = index;

    if (index == 0) {
      LocalStorage.myRoll = "parents";
      LocalStorage.setString(LocalStorageKeys.myRoll, LocalStorage.myRoll);
    } else if (index == 1) {
      LocalStorage.myRoll = "nunny";
      LocalStorage.setString(LocalStorageKeys.myRoll, LocalStorage.myRoll);
    }

    update();
  }
}
