import 'package:flash/const/Colors/color_group.dart';
import 'package:flutter/material.dart';

class AnswerUpload extends StatelessWidget {
  const AnswerUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  '내 풀이 작성',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('업로드', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: ColorGroup.appbarBGC,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 240,
                  width: 169,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(248, 0, 0, 0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    foregroundColor: Color.fromRGBO(0, 87, 255, 1),
                    backgroundColor: Color.fromRGBO(217, 230, 255, 1),

                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ), // 패딩
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24), // 모서리 둥글기
                    ),
                  ),
                  child: Text(
                    '영상 선택하기',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 12),
                        child: Text(
                          '클라이밍장',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 247, 247, 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '더클라임 강남',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 0, 12),
                        child: Text(
                          '난이도',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 247, 247, 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 0, 38, 255),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              ' 파랑',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 0, 12),
                        child: Text(
                          '한줄평',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 247, 247, 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: '한줄평을 작성해주세요',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
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
