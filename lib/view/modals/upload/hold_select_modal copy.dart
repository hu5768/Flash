import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HoldSelectModal extends StatelessWidget {
  void _showMenu(BuildContext context, Offset offset) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      color: Colors.white,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(offset.dx + 100, offset.dy + 58, 0, 0),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          onTap: () {
            SortClick('추천순', 'recommand');
          },
          child: Text("추천순"),
        ),
        PopupMenuItem(
          onTap: () {
            SortClick('인기순', 'views');
          },
          child: Text("인기순"),
        ),
        PopupMenuItem(
          onTap: () {
            SortClick('난이도순', 'difficulty');
          },
          child: Text("난이도순"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.fromLTRB(14, 9, 14, 9),
        side: BorderSide(
          width: 1,
          color: const Color.fromARGB(
            255,
            196,
            196,
            196,
          ),
        ),
        foregroundColor: const Color.fromARGB(255, 115, 115, 115),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: () {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset offset = renderBox.localToGlobal(Offset.zero);
        _showMenu(context, offset);
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/empty_hold.svg',
            ),
            SizedBox(width: 10),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Future<void> SortClick(String title, String sortKey) async {}
}
