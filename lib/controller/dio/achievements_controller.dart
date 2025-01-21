import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/model/achievment_model.dart';
import 'package:flash/model/center_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;
import 'dio_singletone.dart';

class AchievementsController extends GetxController {
  var achievementsList = <AchievementModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    dios.Response response;
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    DioClient().updateOptions(token: token.toString());
    try {
      response = await DioClient().dio.get(
            "/achievements",
          );

      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data);
      List<AchievementModel> am =
          resMap.map((e) => AchievementModel.fromJson(e)).toList();

      /*
      final repository = CenterRepository(DioClient().dio, baseUrl: '');
      List<Centers> um = await repository.getCenterList(); */
      achievementsList.assignAll(am);
      print("업적 $achievementsList");
    } catch (e) {
      print('업적 리스트 로딩 실패$e');
      if (e is DioException) {
        if (e.response != null) {
          print('agree DioError: ${e.response?.headers}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }
}
