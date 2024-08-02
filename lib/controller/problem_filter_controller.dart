import 'package:get/get.dart';

class ProblemFilterController extends GetxController {
  List<String> gradeOption = [];
  List<String> sectorOption = [];
  var allOption = <List<String>>[].obs; //난이도 ,벽 도메인
  var allSelection = <RxList<String>>[].obs; // 문제 리스트 페이지에 반영될 선택 여부
  var allTempSelection = <RxList<String>>[].obs; // 모달에서 선택중인 선택 여부
  var nobodySol = false.obs; // 아무도 못 푼 문제 보기
  var nobodySolTemp = false.obs;

  @override
  void onInit() {
    super.onInit();
    allInit();
  }

  void allInit() {
    allOption.clear();
    allOption.add(gradeOption);
    allOption.add(sectorOption);
    allSelection.clear();
    allSelection.add(<String>[].obs);
    allSelection.add(<String>[].obs);
    allTempSelection.clear();
    allTempSelection.add(<String>[].obs);
    allTempSelection.add(<String>[].obs);
    nobodySol.value = false;
  }

  void inToTemp() {
    //모달 선택 여부<- 문제리스트 선택여부 값 깊은복사
    allTempSelection.clear();
    allTempSelection.addAll(
      allSelection.map((rxlist) => RxList<String>.from(rxlist)).toList(),
    );
    nobodySolTemp.value = nobodySol.value;
  }

  void tempToSel() {
    //모달 선택 여부-> 문제리스트 선택여부 값 깊은복사
    allSelection.clear();
    allSelection.addAll(
      allTempSelection.map((rxlist) => RxList<String>.from(rxlist)).toList(),
    );
    nobodySol.value = nobodySolTemp.value;
  }

  void checkBoxToggle() {
    nobodySol.value = nobodySol.value ? true : false;
  }

  bool allTempEmpty() {
    //모달의 모든 값 비었는지 확인
    bool ans = true;
    for (int i = 0; i < allTempSelection.length; i++) {
      ans &= allTempSelection[i].isEmpty;
    }
    ans &= !nobodySolTemp.value;
    return ans;
  }

  bool allEmpty() {
    //모달의 모든 값 비었는지 확인
    bool ans = true;
    for (int i = 0; i < allSelection.length; i++) {
      ans &= allSelection[i].isEmpty;
    }
    ans &= !nobodySol.value;
    return ans;
  }

  void goEmpty() {
    //모달의 모든 값 초기화
    nobodySolTemp.value = false;
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

  int countFilter() {
    //필터 갯수 리턴
    int cnt = 0;
    for (int i = 0; i < allTempSelection.length; i++) {
      cnt += allSelection[i].length;
    }
    cnt += nobodySol.value ? 1 : 0;
    return cnt;
  }
}
