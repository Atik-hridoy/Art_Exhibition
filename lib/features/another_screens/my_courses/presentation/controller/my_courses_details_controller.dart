import 'package:get/get.dart';

class MyCoursesDetailsController extends GetxController {
    String isType="overview";

  updateType({String? type}){
    // Avoid assigning null to a non-nullable field
    if(type == null || type.isEmpty) return;
    isType = type;
    update();
  }
  
}