import 'package:flash/view/centers/center_detail_page.dart';
import 'package:flutter/material.dart';

class CenterCard extends StatelessWidget {
  final int id;
  final String title, thum;
  const CenterCard({
    super.key,
    required this.id,
    required this.title,
    required this.thum,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CenterDetailPage(id: id, title: title, thum: thum),
            allowSnapshotting: true,
          ),
        );
      },
      child: Container(
        height: 100,
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(
              thum,
              width: 70,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 70,
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
