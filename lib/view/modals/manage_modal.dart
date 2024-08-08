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
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 34),
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 247, 247, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 45,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  minVerticalPadding: 20,
                  leading: Icon(Icons.edit, color: Colors.black),
                  title: Text(
                    '수정하기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // 수정하기 클릭 시 동작
                    Navigator.pop(context);
                  },
                ),
                Divider(height: 1),
                ListTile(
                  minVerticalPadding: 20,
                  leading: Icon(Icons.delete, color: Colors.black),
                  title: Text(
                    '삭제하기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // 삭제하기 클릭 시 동작
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
