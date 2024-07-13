import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flash/Colors/color_group.dart';
import 'package:flash/view/answers/answers_carousell_page.dart';
import 'package:flutter/material.dart';

class ProblemCard extends StatelessWidget {
  final String sector;
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  const ProblemCard({
    super.key,
    required this.sector,
  });
  Future<void> _sendAnalyticsEvent(String tmp) async {
    await analytics.logEvent(
      name: 'button_click_test$tmp',
      parameters: <String, Object>{
        'button_name': 'testtest',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _sendAnalyticsEvent(sector);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnswersCarousell(sector: sector),
            allowSnapshotting: true,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorGroup.cardBGC,
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  'assets/images/problem.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.circle,
                        color: Color.fromARGB(255, 0, 47, 255),
                      ),
                      Text(
                        sector,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text("세팅일: 07/01"),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        "영상 있음",
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text("파랑"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
