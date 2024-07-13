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
    print("클라이밍 리스트 로딩중");
  }

  void fetchData() async {
    dios.Response response;
    try {
      response = await DioClient().dio.get(
            "/gyms",
          );
      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data);
      List<Centers> um = resMap.map((e) => Centers.fromJson(e)).toList();
      centerCon.assignAll(um);
    } catch (e) {
      List<Centers> um = [
        Centers(id: 1, gymName: '오류오류오류', thumbnailUrl: ''),
      ];
      centerCon.assignAll(um);
    }
  }
}
