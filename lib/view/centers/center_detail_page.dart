import 'package:flutter/material.dart';

class CenterDetailPage extends StatelessWidget {
  final int id;
  final String title, thum;
  const CenterDetailPage({
    super.key,
    required this.id,
    required this.title,
    required this.thum,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
