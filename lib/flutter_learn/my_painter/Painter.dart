import 'package:flutter/material.dart';

class MyPainter1 extends CustomPainter {
  final Rect _rect = const Rect.fromLTWH(10, 10, 110, 110);
  final Paint _myPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(_rect, _myPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
