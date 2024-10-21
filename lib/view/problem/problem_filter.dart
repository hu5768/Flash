import 'package:flash/const/Colors/color_group.dart';
import 'package:flutter/material.dart';

class ProblemFilter extends StatelessWidget {
  const ProblemFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          Image.asset('assets/images/gym_map.png'),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '섹터',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: VerticalDivider(
                          color: const Color.fromARGB(255, 196, 196, 196),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: ChoiceChip(
                          labelPadding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          visualDensity: VisualDensity(vertical: 0.0),
                          showCheckmark: false,
                          label: Text(
                            '1 & 2',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 17, 17, 17),
                              height: 1,
                            ),
                          ),
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: const Color.fromARGB(255, 196, 196, 196),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          selected: false,
                          onSelected: (bool selected) {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
