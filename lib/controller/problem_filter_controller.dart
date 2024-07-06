import 'package:get/get.dart';

class ProblemFilterController extends GetxController {
  var gradeOption = ["초록", "파랑", "빨강", "보라", "회색"];
  var sectorOption = ["1&2", "3&4", "5&6", "7&8"];
  var allOption = <List<String>>[].obs;
  var allSelection = <RxList<String>>[].obs; //0:difficulty , 1:sector, 2: ??
  @override
  void onInit() {
    super.onInit();
    allOption.add(gradeOption);
    allOption.add(sectorOption);
    allSelection.add(<String>[].obs);
    allSelection.add(<String>[].obs);
  }

  void toggleSelection(String option, int index) {
    if (allSelection[index].contains(option)) {
      allSelection[index].remove(option);
    } else {
      allSelection[index].add(option);
    }
  }
}
