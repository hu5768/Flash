import 'package:flutter/material.dart';

class ProblemCard extends StatelessWidget {
  const ProblemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              child: Image.asset('assets/images/problemImg.png'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "더클라임 강남 3&4",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("세팅일: 07/01"),
                  ],
                ),
                Row(
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
    );
  }
}
