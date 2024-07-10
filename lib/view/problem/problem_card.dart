import 'package:flash/view/answers/answers_carousell.dart';
import 'package:flutter/material.dart';

class ProblemCard extends StatelessWidget {
  final String sector;
  const ProblemCard({
    super.key,
    required this.sector,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                  color: const Color.fromARGB(255, 231, 246, 253),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      Icon(
                        Icons.circle,
                        color: Color.fromARGB(255, 0, 47, 255),
                      ),
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
