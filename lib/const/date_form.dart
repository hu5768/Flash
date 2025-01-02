import 'package:intl/intl.dart';

String formatDateString(String dateString) {
  // 문자열을 DateTime 객체로 파싱합니다.
  DateTime dateTime = DateTime.parse(dateString);

  // 연도 형식을 변경합니다.
  String year = DateFormat('yy').format(dateTime);

  // 월과 일을 한국어 형식으로 포맷팅합니다.
  String month = DateFormat('MM').format(dateTime);
  String day = DateFormat('dd').format(dateTime);

  return '$year.$month.$day';
}

String formatDateDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatDouble(double value) {
  // 값이 정수인지 확인
  if (value == value.toInt()) {
    return value.toInt().toString(); // 정수로 변환 후 문자열 반환
  }
  return value.toString(); // 그대로 문자열로 반환
}
