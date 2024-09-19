import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static var version = 'v1'; //출시 전 test

  static Future<void> screenView(String screenName, String nickName) async {
    //제보페이지
    await analytics.logScreenView(
      screenName: 'FlashApp_{$version}_screenView_$screenName',
      parameters: <String, Object>{
        'nickName': nickName,
      },
    );
  }

  static Future<void> buttonClick(
    String pageName,
    String buttonName,
    String gymName,
    String buttoninfo,
  ) async {
    //print("fba 버튼클릭$pageName $buttonName");
    //버튼클릭 이벤트
    await analytics.logEvent(
      name: 'FlashApp_${version}_button_$pageName',
      parameters: <String, Object>{
        'buttoninfo': buttoninfo,
        'buttonName': buttonName,
        'gymName': gymName,
      },
    );
  }

  static Future<void> problemClick(
    //문제 선택 이벤트
    String id,
    String difficulty,
    String sector,
    String hasSolution,
  ) async {
    //print("fba 문제선택");
    await analytics.logEvent(
      name: 'FlashApp_${version}_ClickProblem',
      parameters: <String, Object>{
        'id': id,
        'difficulty': difficulty,
        'sector': sector,
        'hasSolution': hasSolution,
      },
    );
  }

  static Future<void> sendVedioEvent(
    //비디오 플레이 이벤트
    String type,
    String useuri,
  ) async {
    await analytics.logEvent(
      name: 'FlashApp_{$version}_video',
      parameters: <String, Object>{
        'type': type,
        'videoUrl': useuri,
      },
    );
  }

  static Future<void> modalClick(
    String buttonName,
    String gymName,
    String diffOption,
    String secOption,
    String nobodySol,
  ) async {
    //필터 모달 버튼
    //print("fba 모달 $buttonName");
    await analytics.logEvent(
      name: 'FlashApp_{$version}_modal_$buttonName',
      parameters: <String, Object>{
        'gymName': diffOption,
        'diffOption': diffOption,
        'secOption': secOption,
        'nobodySol': nobodySol,
      },
    );
  }

  static Future<void> answerSlide(
    //비디오 플레이 이벤트

    String index,
    String id,
    String difficulty,
    String sector,
  ) async {
    // print("fba video $index");
    await analytics.logEvent(
      name: 'FlashApp_{$version}_slider',
      parameters: <String, Object>{
        'index': index,
        'id': id,
        'difficulty': difficulty,
        'sector': sector,
      },
    );
  }
}
