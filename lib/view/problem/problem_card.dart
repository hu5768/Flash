import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/answers/answers_carousell_page.dart';
import 'package:flutter/material.dart';

class ProblemCard extends StatelessWidget {
  final String id, sector, difficulty, settingDate, removalDate, imageUrl;
  final bool hasSolution;

  const ProblemCard({
    super.key,
    required this.id,
    required this.sector,
    required this.difficulty,
    required this.settingDate,
    required this.removalDate,
    required this.hasSolution,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AnalyticsService.sendProblemCardEvent(
          id,
          difficulty,
          sector,
          hasSolution.toString(),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnswersCarousell(id: id),
            allowSnapshotting: true,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: ColorGroup.cardBGC,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 3 / 4,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/problem.jpeg',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /*const Icon(
                          Icons.circle,
                          color: Color.fromARGB(255, 0, 47, 255),
                        ),*/
                        Text(
                          sector,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text("세팅일: $settingDate"),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        hasSolution
                            ? const Text(
                                "영상 있음",
                              )
                            : const Text(
                                "영상 없음",
                              ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(difficulty),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
