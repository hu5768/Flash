import 'package:get/get.dart';

class ProblemSortController extends GetxController {
  var sortkey = 'recommand'.obs;
  var sorttitle = '추천순'.obs;

  @override
  void onInit() {
    super.onInit();
    allInit();
  }

  void changeText(String newKey, String newTitle) {
    sortkey.value = newKey;
    sorttitle.value = newTitle;
  }

  void allInit() {
    sortkey.value = 'recommand';
    sorttitle.value = '추천순';
  }
}
