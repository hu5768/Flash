import 'package:dio/dio.dart';
import 'package:flash/const/webtoken.dart';
import 'package:flash/model/center_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;
import 'dio_singletone.dart';

class CenterListController extends GetxController {
  var centerCon = <Centers>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    dios.Response response;
    try {
      DioClient().updateOptions(token: webtoken);
      response = await DioClient().dio.get(
            "/gyms",
          );
      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data);
      List<Centers> um = resMap.map((e) => Centers.fromJson(e)).toList();
      centerCon.assignAll(um);
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
