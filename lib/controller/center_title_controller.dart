import 'package:flash/controller/first_answer_controller.dart';
import 'package:flash/controller/login_controller.dart';
import 'package:flash/view/centers/center_detail_model.dart';
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
  var centerDetailModel = CenterDetailModel().obs;
  var problemFilterController = Get.put(ProblemFilterController());
  var firstAnswerController = Get.put(FirstAnswerController());
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
      centerDetailModel.value = CenterDetailModel.fromJson(resMap);

      //gym이름
      centerTitle.value = centerDetailModel.value.gymName!;

      //난이도 리스트
      problemFilterController.gradeOption =
          centerDetailModel.value.difficulties!;
      firstAnswerController.gradeOption = centerDetailModel.value.difficulties!;

      //섹터 이름 리스트
      problemFilterController.sectorOption = centerDetailModel.value.sectors!
              .map((sector) => sector.name ?? '')
              .toList() ??
          [];
      firstAnswerController.sectorOption = centerDetailModel.value.sectors!
              .map((sector) => sector.name ?? '')
              .toList() ??
          [];

      problemFilterController.allInit();
    } catch (e) {
      print('암장 타이틀 실패$e');

      centerTitle.value = '암장을 불러오지 못했습니다.';
    }
  }
}
