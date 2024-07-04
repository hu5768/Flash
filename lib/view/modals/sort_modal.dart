import 'package:flash/controller/center_sort_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortModal extends StatelessWidget {
  const SortModal({super.key});
  //컨트롤러 자료형 없이 등록하면 어떻게 되는지 질문
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 50,
              ),
              const Text(
                "문제 정렬",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SortOrder(
            title: '추천순',
            sortKey: 'none',
          ),
          SortOrder(title: '인기순', sortKey: 'views'),
          SortOrder(title: '난이도순', sortKey: 'difficulty'),
        ],
      ),
    );
  }
}

class SortOrder extends StatelessWidget {
  final CenterSortController centerTitleController = Get.find();
  final String title, sortKey;
  SortOrder({
    super.key,
    required this.title,
    required this.sortKey,
  });

  @override
  Widget build(BuildContext context) {
    print(centerTitleController.sortkey.toString() + sortKey);
    return Column(
      children: [
        const Divider(),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              centerTitleController.sortkey.toString() == sortKey
                  ? const Icon(Icons.check, color: Colors.blue)
                  : const SizedBox(),
              Center(child: Text(title)),
            ],
          ),
          onTap: () {
            centerTitleController.changeText(sortKey, title);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
