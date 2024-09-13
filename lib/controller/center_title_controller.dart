import 'package:dio/dio.dart';
import 'package:flash/const/webtoken.dart';
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
      DioClient().updateOptions(token: webtoken);
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
    } on DioException catch (e) {
      // 에러가 발생했을 때 서버로부터의 응답 확인
      if (e.response != null) {
        print('서버 에러 응답 데이터: ${e.response!.data}');
        print('서버 에러 상태 코드: ${e.response!.statusCode}');
        print('서버 에러 헤더: ${e.response!.headers}');
      } else {
        // 서버로부터 응답을 받지 못한 경우
        print('요청 실패: ${e.message}');
      }
    }
  }
}
