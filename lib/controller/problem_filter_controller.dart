import 'package:get/get.dart';

class ProblemFilterController extends GetxController {
  var gradeOption = ["초록", "파랑", "빨강", "보라", "회색"];
  var sectorOption = ["1&2", "3&4", "5&6", "7&8"];
  var allOption = <List<String>>[].obs;
  var allSelection = <RxList<String>>[].obs; //0:difficulty , 1:sector, 2: ??
  var allTempSelection = <RxList<String>>[].obs;

  var nobodySol = false.obs;
  @override
  void onInit() {
    super.onInit();
    allOption.add(gradeOption);
    allOption.add(sectorOption);
    allSelection.add(<String>[].obs);
    allSelection.add(<String>[].obs);
    allTempSelection.add(<String>[].obs);
    allTempSelection.add(<String>[].obs);
  }

  void inToTemp() {
    allTempSelection.clear();
    allTempSelection.addAll(
      allSelection.map((rxlist) => RxList<String>.from(rxlist)).toList(),
    );
  }

  void tempToSel() {
    allSelection.clear();
    allSelection.addAll(
      allTempSelection.map((rxlist) => RxList<String>.from(rxlist)).toList(),
    );
  }

  void checkBoxToggle() {
    nobodySol.value = nobodySol.value ? true : false;
  }

  bool allEmpty() {
    bool ans = true;
    for (int i = 0; i < allTempSelection.length; i++) {
      ans &= allTempSelection[i].isEmpty;
    }
    return ans;
  }

  void goEmpty() {
    for (int i = 0; i < allTempSelection.length; i++) {
      allTempSelection[i].clear();
    }
  }

  void toggleSelection(String option, int index) {
    if (allTempSelection[index].contains(option)) {
      allTempSelection[index].remove(option);
    } else {
      allTempSelection[index].add(option);
    }
  }
}
