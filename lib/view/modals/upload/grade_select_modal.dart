import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GradeSelectModal extends StatelessWidget {
  void _showMenu(BuildContext context, Offset offset) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      color: Colors.white,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + 8,
        overlay.size.width - offset.dx + 112, // 오른쪽 공간
        0,
      ),
      items: [
        PopupMenuItem(
          onTap: () {},
          child: Container(
            color: Colors.blue,
          ),
        ),
        PopupMenuItem(
          onTap: () {},
          child: Text(
            "보통이에요",
            style: TextStyle(fontSize: 16),
          ),
        ),
        PopupMenuItem(
          onTap: () {},
          child: Text(
            "어려워요",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
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
        Offset offset = renderBox.localToGlobal(
          Offset(
            0,
            renderBox.size.height,
          ),
        );
        _showMenu(context, offset);
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/empty_color.svg',
            ),
            SizedBox(width: 10),
            Icon(
              Icons.keyboard_arrow_down,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> SortClick(String title, String sortKey) async {}
}
