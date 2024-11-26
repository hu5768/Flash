import 'package:flutter/material.dart';

class TransparentSquareThumb extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(43, 43); // Thumb 크기 조정
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // 투명한 사각형을 그리기 위한 Paint
    final Paint paint = Paint()
      ..color = Colors.blue // 테두리 색상
      ..style = PaintingStyle.stroke // 내부를 비우기 위해 Stroke 설정
      ..strokeWidth = 4.0;

    // Thumb 사각형 그리기
    final double thumbSize = 43; // 사각형 크기
    final Rect thumbRect = Rect.fromCenter(
      center: center,
      width: thumbSize,
      height: 77,
    );

    canvas.drawRect(thumbRect, paint);

    // 투명한 가운데 사각형(생략: 이미 내부가 투명)
  }
}
