import 'package:flash/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;
import 'dio_singletone.dart';
import 'problem_filter_controller.dart';

class CenterTitleController extends GetxController {
  var centerId = 1.obs;
  var centerTitle = ''.obs;
  late String mapImgUrl;
  late List<String> gradeDifficulties;
  late List<String> secterList;
  @override
  void onInit() {
    super.onInit();
    getTitle();
  }

  void changeId(int newId) {
    centerId.value = newId;
  }

  void getTitle() async {
    dios.Response response;
    try {
      DioClient().updateOptions(token: LoginController.accessstoken);
      response = await DioClient().dio.get(
            "/gyms/${centerId.value}",
          );

      Map<String, dynamic> resMap = Map<String, dynamic>.from(response.data);

      centerTitle.value = resMap['gymName'];
      mapImgUrl = resMap['mapImageUrl'];

      ProblemFilterController problemFilterController = Get.find();

      gradeDifficulties = List<String>.from(resMap['difficulties']);

      problemFilterController.gradeOption = gradeDifficulties;

      secterList = List<String>.from(resMap['sectors']);
      problemFilterController.sectorOption = secterList;

      problemFilterController.allInit();
    } catch (e) {
      print('암장 리스트 실패$e');

      centerTitle.value = '암장을 불러오지 못했습니다.';
    }
  }
}
