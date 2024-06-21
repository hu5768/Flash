import 'package:flash/model/center_model.dart';
import 'package:get/get.dart';

class CenterListController extends GetxController {
  var centerCon = <Centers>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    var centerDataEX = [
      Centers(
        id: 1,
        title: "더클라임 양재",
        thum:
            "https://mblogthumb-phinf.pstatic.net/MjAyNDA1MjZfMjEx/MDAxNzE2NzE3MTc3NTQx.ybOj2JeimNJS9XwY_7N1RRJHYw-WWgu0yQJHeC0a90cg.q8DqSUyQLL-XiAtxd2G1KE5Iw1_t4M1tKKJAvLoNkqQg.PNG/image.png?type=w800",
      ),
      Centers(
        id: 2,
        title: "더클라임 강남",
        thum:
            "https://mblogthumb-phinf.pstatic.net/MjAyNDA1MjZfMTAx/MDAxNzE2NzE3MTM3MTU0.mErXs7Ce5E_2HxVQNTIiUQ5mLNEPsKiPmnkxW7F4FcMg.bFfqx6Swwkrarv6JZ-O4IYWweLgHdEF3t1dJAB9mRVMg.PNG/image.png?type=w800",
      ),
      Centers(
        id: 3,
        title: "더클라임 논현",
        thum:
            "https://mblogthumb-phinf.pstatic.net/MjAyNDA1MjZfMjE5/MDAxNzE2NzE3MTQ3Mzc2.igx0XA_q2x_IEj_aIR0DaCsdEoWo3PEDON3zyuGZMD8g.IdhV1Y7zMyBdyNz3wovmNkOcI6Qu9vXK9BZQhxZjEh0g.PNG/image.png?type=w800",
      ),
    ];
    centerCon.assignAll(centerDataEX);
  }
}
