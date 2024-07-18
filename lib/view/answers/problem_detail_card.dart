import 'package:flash/technology_test/video_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProblemDetailCard extends StatelessWidget {
  final String sector, difficulty, settingDate, removalDate, imgUrl;
  final bool hasSolution;
  const ProblemDetailCard({
    super.key,
    required this.sector,
    required this.difficulty,
    required this.settingDate,
    required this.removalDate,
    required this.imgUrl,
    required this.hasSolution,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.network(
                imgUrl,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '더클라임 강남 $sector',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InfoText(
                    title: '영상',
                    textInfo: hasSolution ? '영상 있음' : '영상 없음',
                  ),
                  InfoText(title: '난이도', textInfo: difficulty),
                  InfoText(title: '탈거일', textInfo: settingDate),
                  InfoText(title: '세팅일', textInfo: removalDate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  final String title, textInfo;
  const InfoText({
    super.key,
    required this.title,
    required this.textInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          textInfo,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
