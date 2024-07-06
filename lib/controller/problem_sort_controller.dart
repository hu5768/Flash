import 'package:get/get.dart';

class ProblemSortController extends GetxController {
  var sortkey = 'none'.obs;
  var sorttitle = '추천순'.obs;
  void changeText(String newKey, String newTitle) {
    sortkey.value = newKey;
    sorttitle.value = newTitle;
  }
}
