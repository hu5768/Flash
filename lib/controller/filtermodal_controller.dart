import 'package:get/get.dart';

class FiltermodalController extends GetxController {
  var allOption = <List<String>>[].obs;
  var allSelection = <RxList<String>>[].obs; //0:difficulty , 1:sector, 2: ??
  @override
  void onInit() {
    super.onInit();
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
