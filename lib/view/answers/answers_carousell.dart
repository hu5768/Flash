import 'package:flash/view/answers/answer_card.dart';
import 'package:flutter/material.dart';

class AnswersCarousell extends StatelessWidget {
  final String sector;
  const AnswersCarousell({
    super.key,
    required this.sector,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Container(
          height: AppBar().preferredSize.height,
          decoration: const BoxDecoration(),
          child: Row(
            children: [
              const SizedBox(
                width: 120,
              ),
              Center(
                child: Text(
                  sector,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ),
      body: const AnswerCard(),
    );
  }
}
