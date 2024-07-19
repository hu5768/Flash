import 'package:firebase_analytics/firebase_analytics.dart';
/*
class AnalyticsService {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> sendCopyEvent(String tmp) async {
    //제보페이지 버튼
    await analytics.logEvent(
      name: '(test)button_click : $tmp',
      parameters: <String, Object>{
        'page': 'report_page',
      },
    );
  }

  static Future<void> sendMainButtonEvent(String tmp, String gym) async {
    //문제리스트 페이지 버튼
    await analytics.logEvent(
      name: '(test)button_click : $tmp',
      parameters: <String, Object>{
        'page': 'problem_list_page',
        'gym': gym,
      },
    );
  }

  static Future<void> sendCenterButtonEvent(String tmp) async {
    //암장리스트 페이지 버튼
    await analytics.logEvent(
      name: '(test)button_click : $tmp',
      parameters: <String, Object>{
        'page': 'center_list_page',
      },
    );
  }

  static Future<void> sendAnswerButtonEvent(String tmp) async {
    //답지리스트 페이지 버튼
    await analytics.logEvent(
      name: '(test)button_click : $tmp',
      parameters: <String, Object>{
        'page': 'answer_list_page',
      },
    );
  }

  static Future<void> sendProblemCardEvent(
    //문제 선택 이벤트
    String tmp,
    String difficulty,
    String sector,
    String hasSolution,
  ) async {
    await analytics.logEvent(
      name: '(test)problem_click id:$tmp',
      parameters: <String, Object>{
        'page': 'problem_list_page',
        'difficulty': difficulty,
        'sector': sector,
        'hasSolution': hasSolution,
      },
    );
  }

  static Future<void> sendVedioEvent(
    //비디오 플레이 이벤트
    String tmp,
    String useuri,
  ) async {
    await analytics.logEvent(
      name: '(test)video id:$tmp',
      parameters: <String, Object>{
        'page': 'answer_list_page',
        'videoUrl': useuri,
      },
    );
  }

  static Future<void> sendSortModalEvent(String tmp) async {
    //정렬 모달 버튼
    await analytics.logEvent(
      name: '(test)sort_tap_click : $tmp',
      parameters: <String, Object>{
        'page': 'sort_modal',
      },
    );
  }

  static Future<void> sendFilterModalEvent(String tmp, String domain) async {
    //필터 모달 버튼
    await analytics.logEvent(
      name: '(test)filter_tap_click : $tmp',
      parameters: <String, Object>{
        'page': 'sort_modal',
        'domain': domain,
      },
    );
  }
}
*/