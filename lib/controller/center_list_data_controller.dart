import 'package:flash/controller/login_controller.dart';
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
      DioClient().updateOptions(token: LoginController.accessstoken);
      response = await DioClient().dio.get(
            "/gyms",
          );
      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data);
      List<Centers> um = resMap.map((e) => Centers.fromJson(e)).toList();
      centerCon.assignAll(um);
    } catch (e) {
      print('암장 리스트 로딩 실패$e');
    }
  }
}
