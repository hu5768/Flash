import 'package:flutter/material.dart';

class UploadPageTutorial extends StatefulWidget {
  const UploadPageTutorial({super.key});

  @override
  State<UploadPageTutorial> createState() => _MainPageTutorialState();
}

class _MainPageTutorialState extends State<UploadPageTutorial> {
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (1 <= page && page <= 2)
            Image.asset('assets/images/tutorial/upload_tutorial$page.png'),
          Positioned(
            left: 0,
            right: 0,
            bottom: 80,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      if (page > 1) page -= 1;
                      setState(() {});
                    },
                    child: Text(
                      "이전",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '$page / 2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (page == 2)
                        Navigator.pop(context);
                      else {
                        setState(() {
                          page += 1;
                        });
                      }
                    },
                    child: Text(
                      page == 2 ? '닫기' : "다음",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
