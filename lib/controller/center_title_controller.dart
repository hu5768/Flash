import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;
import 'dio_singletone.dart';

class CenterTitleController extends GetxController {
  var centerId = 2.obs;
  var centerTitle = '더클라임 강남'.obs;
  void changeId(int newId) {
    centerId.value = newId;
  }

  void getTitle() async {
    dios.Response response;
    print(centerId.value.toString());
    try {
      /*response = await DioClient().dio.get("/gyms/$centerId.value");
      Map<String, dynamic> resMap = Map<String, dynamic>.from(response.data);
      print(resMap);*/
    } catch (e) {
      print('실패');
      print(e);
    }
  }
}
