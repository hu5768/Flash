import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;
import 'dio_singletone.dart';
import 'problem_filter_controller.dart';

class CenterTitleController extends GetxController {
  var centerId = 1.obs;
  var centerTitle = ''.obs;
  late String mapImgUrl;
  late List<Map<String, dynamic>> gradeDifficulties;
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
    print(centerId.value.toString());
    try {
      response = await DioClient().dio.get("/gyms/${centerId.value}");
      Map<String, dynamic> resMap = Map<String, dynamic>.from(response.data);
      centerTitle.value = resMap['gymName'];
      mapImgUrl = resMap['mapImageUrl'];

      gradeDifficulties =
          List<Map<String, dynamic>>.from(resMap['difficulties']);
      print(gradeDifficulties);
      ProblemFilterController problemFilterController = Get.find();
      problemFilterController.gradeOption =
          gradeDifficulties.map((a) => a['name'] as String).toList();
      problemFilterController.allInit();
    } catch (e) {
      print('실패');
      print(e);
    }
  }
}
