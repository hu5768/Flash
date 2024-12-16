import 'package:get/get.dart';

class ProblemFilterController extends GetxController {
  List<String> gradeOption = [];
  List<String> sectorOption = [];
  List<String> sectorImageUrl = [];
  var sectorImageUrlString = ''.obs;

  var allOption = <List<String>>[].obs; //난이도 ,벽 도메인
  var allSelection = <RxList<String>>[].obs; // 문제 리스트 페이지에 반영될 선택 여부

  var nobodySol = false.obs; // 아무도 못 푼 문제 보기
  var isHoney = false.obs; // 꿀 문제 보기

  @override
  void onInit() {
    super.onInit();
    allInit();
  }

  Future<void> allInit() async {
    allOption.clear();
    allOption.add(gradeOption);
    allOption.add(sectorOption);
    allSelection.clear();
    allSelection.add(<String>[].obs);
    allSelection.add(<String>[].obs);
    sectorImageUrlString.value = '';
    nobodySol.value = false;
    isHoney.value = false;
  }

  bool allEmpty() {
    //모달의 모든 값 비었는지 확인
    bool ans = true;
    for (int i = 0; i < allSelection.length; i++) {
      ans &= allSelection[i].isEmpty;
    }
    ans &= !nobodySol.value;
    ans &= !isHoney.value;
    return ans;
  }

// new
  void SectorSelection(String option, int index) {
    if (allSelection[1].contains(option)) {
      allSelection[1].remove(option);
      sectorImageUrlString.value = '';
    } else {
      allSelection[1].clear();
      allSelection[1].add(option);
      sectorImageUrlString.value = sectorImageUrl[index];
    }
  }

  void GradeSelection(String option) {
    if (allSelection[0].contains(option)) {
      allSelection[0].remove(option);
    } else {
      //allSelection[1].clear();
      allSelection[0].add(option);
    }
  }
}
