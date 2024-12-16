import 'package:dio/dio.dart' as dios;
import 'package:dio/dio.dart';
import 'package:flash/controller/first_answer_controller.dart';
import 'package:flash/controller/login_controller.dart';
import 'package:flash/model/hold_color_model.dart';
import 'package:get/get.dart';
import 'dio_singletone.dart';

class HoldColorController extends GetxController {
  final firstAnswerController = Get.put(FirstAnswerController());

  Future<void> getHolds() async {
    dios.Response response;

    try {
      DioClient().updateOptions(token: LoginController.accessstoken);
      response = await DioClient().dio.get(
            "/holds",
          );

      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data["holdList"]);
      List<HoldColorModel> hm =
          resMap.map((e) => HoldColorModel.fromJson(e)).toList();
      print(response.data["holdList"]);
      firstAnswerController.HoldOption = hm.map((hold) {
        return hold.colorCode ?? '';
      }).toList();
      firstAnswerController.Holdid = hm.map((hold) {
        return hold.id ?? 0;
      }).toList();
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
      print("홀드색로딩오류$e");
    }
  }
}
