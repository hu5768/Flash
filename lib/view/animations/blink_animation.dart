import 'package:flash/const/data.dart';
import 'package:flutter/material.dart';

class BlinkAnimation extends StatefulWidget {
  const BlinkAnimation({super.key});

  @override
  State<BlinkAnimation> createState() => _BlinkAnimationState();
}

class _BlinkAnimationState extends State<BlinkAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _blinkCount = 0;
  bool seeGuide = true;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500), // 한 번 깜빡이는 시간 설정
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _blinkCount++;
          if (_blinkCount < 3) {
            _controller.forward();
          }
        }
      });

    _controller.forward(); // 애니메이션 시작
  }

  @override
  void dispose() {
    _controller.dispose();
    storage.write(
      key: GESTURE_GUIDE,
      value: 'NULL',
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        seeGuide = false;
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        body: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: seeGuide
                    ? Image.asset('assets/images/gesture_guide.png')
                    : null,
              );
            },
          ),
        ),
      ),
    );
  }
}
