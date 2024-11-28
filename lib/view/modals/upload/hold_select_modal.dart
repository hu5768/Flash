import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HoldSelectModal extends StatelessWidget {
  void _showMenu(BuildContext context, Offset offset) async {
    showDialog(
      context: context,
      barrierColor: Colors.transparent, // 배경 클릭 감지
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              right: MediaQuery.of(context).size.width - offset.dx, //오른쪽 부터 계산
              top: offset.dy + 10,
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 200, // 메뉴의 전체 너비
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: GridView.count(
                  crossAxisCount: 4, // 한 행에 2개의 아이템
                  shrinkWrap: true, // 크기 자동 조정
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: [
                    Icon(Icons.abc),
                    Icon(Icons.abc),
                    Icon(Icons.abc),
                    Icon(Icons.abc),
                    Icon(Icons.abc),
                    Icon(Icons.abc),
                  ],
                ),
              ),
            ),
          ],
        );
      },
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
        Offset offset = renderBox.localToGlobal(
          Offset(
            renderBox.size.width,
            0,
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
