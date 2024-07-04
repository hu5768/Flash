import 'package:flutter/material.dart';

class FilterModal extends StatelessWidget {
  const FilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              const Text("문제 필터링"),
              IconButton(onPressed: () {}, icon: const Icon(Icons.close))
            ],
          ),
        ],
      ),
    );
  }
}
