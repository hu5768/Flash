import 'package:flutter/material.dart';

class MainPageTutorial extends StatefulWidget {
  const MainPageTutorial({super.key});

  @override
  State<MainPageTutorial> createState() => _MainPageTutorialState();
}

class _MainPageTutorialState extends State<MainPageTutorial> {
  @override
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (1 <= page && page <= 4)
            Image.asset('assets/images/tutorial/main_tutorial$page.png'),
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
                    '$page / 4',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (page == 4) {
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          page += 1;
                        });
                      }
                    },
                    child: Text(
                      page == 4 ? '닫기' : "다음",
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
