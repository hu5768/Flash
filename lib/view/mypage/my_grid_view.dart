import 'package:flutter/material.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 그리드 열 수
        childAspectRatio: 0.7, // 카드의 종횡비
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.black26,
        );
      },
    );
  }
}
