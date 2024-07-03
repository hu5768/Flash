import 'package:get/get.dart';

class CenterTitleController extends GetxController {
  var centerTitle = '더클라임 강남'.obs;
  void changeText(String newText) {
    centerTitle.value = newText;
  }
}
