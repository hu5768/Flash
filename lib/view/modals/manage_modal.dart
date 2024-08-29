import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';

class ManageModal extends StatelessWidget {
  ManageModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 8, 24, 50),
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 247, 247, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromARGB(213, 213, 213, 255),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 22, 0, 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.edit, color: Colors.black),
                        SizedBox(width: 16),
                        Text(
                          '수정하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Color.fromRGBO(246, 246, 246, 1),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 22, 0, 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.delete, color: Colors.black),
                        SizedBox(width: 16),
                        Text(
                          '수정하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
