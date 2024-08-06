import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';

class BlockModal extends StatelessWidget {
  BlockModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 34),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 242, 242, 242),
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
                Text('추후 추가될 기능입니다'),
                ListTile(
                  minVerticalPadding: 20,
                  leading: Icon(Icons.block, color: Colors.black),
                  title: Text(
                    '차단하기',
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
                  leading: Icon(
                    Icons.error_outline,
                    color: const Color.fromARGB(255, 255, 0, 0),
                  ),
                  title: Text(
                    '신고하기',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 0, 0),
                    ),
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
