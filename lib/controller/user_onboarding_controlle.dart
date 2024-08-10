import 'package:get/get.dart';

class UserOnboardingControlle extends GetxController {
  var onboardIndex = 1.obs;
  int maxIndex = 6;

  void nextPage() {
    if (onboardIndex.value < maxIndex)
      onboardIndex.value += 1;
    else {}
  }

  void backPage() {
    if (onboardIndex.value > 1)
      onboardIndex.value -= 1;
    else {}
  }
}
