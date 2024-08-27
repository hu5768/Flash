import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});
  final String reportForm =
      '제목: [닉네임] 영상 제보합니다!\n영상\n(선택)인스타 계정:  \n(선택)한 줄 평: ex)\n1번 한줄평 : 탑 전 홀드를 잡고 왼발을 오른쪽으로 빼며 카운터 밸런스를 이용하면 쉽게 풀려요! \n3번 한줄평 : 보라치고 쉬워요';
  final String myEmail = 'flashclimbing3@gmail.com';
  final String personalInformation =
      'https://sites.google.com/view/flash-climbing/%ED%99%88';
  Future<void> OpenPI() async {
    await launchUrl(
      Uri.parse(personalInformation),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AnalyticsService.buttonClick('제보 페이지', '제보페이지 닫기 버튼', '');
            Navigator.pop(context);
          },
        ),
        surfaceTintColor: ColorGroup.BGC, //스크롤시 바뀌는 색
        backgroundColor: ColorGroup.appbarBGC,
        title: const Text(
          '영상 제보하기',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '여러분의 풀이를 제보해주세요!\n보내주신 풀이 영상은 저희 답지에 업로드 됩니다.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(122, 116, 116, 1),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '제보 양식',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorGroup.selectBtnBGC,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              reportForm,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 15,
                        right: 10,
                        child: CopyButton(copyText: reportForm, analText: "양식"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '이메일',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorGroup.selectBtnBGC,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                        child: Text(
                          myEmail,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 10,
                        child: CopyButton(copyText: myEmail, analText: "이메일"),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: OpenPI,
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      EdgeInsets.zero,
                    ),
                    minimumSize: WidgetStateProperty.all<Size>(
                      Size(0, 0),
                    ), // 최소 크기 설정
                  ),
                  child: Text(
                    '개인정보 처리방침',
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CopyButton extends StatelessWidget {
  final String copyText, analText;
  const CopyButton({
    super.key,
    required this.copyText,
    required this.analText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AnalyticsService.buttonClick('제보 페이지', '$analText 복사 버튼', '');
        Clipboard.setData(ClipboardData(text: copyText));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        fixedSize: const Size(90, 10),
        side: const BorderSide(
          color: ColorGroup.selectBtnBGC,
          width: 1.5,
        ),
        foregroundColor: ColorGroup.selectBtnBGC,
        backgroundColor: ColorGroup.modalSBtnBGC,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(0),
        child: Text('복사하기', style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
