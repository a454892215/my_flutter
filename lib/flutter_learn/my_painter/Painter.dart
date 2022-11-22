import 'dart:ui';

import 'package:flutter/material.dart';

class MyPainter1 extends CustomPainter {
  final Rect _rect = const Rect.fromLTWH(10, 10, 110, 110);
  final Paint _myPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(_rect, _myPaint);
    // 绘制文本
    drawTextSample(size, canvas);
  }

  void drawTextSample(Size size, Canvas canvas) {
    // 绘制文本
    ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle())..addText('Hello World');
    ParagraphConstraints paragraphConstraints = ParagraphConstraints(width: size.width);
    Paragraph paragraph = paragraphBuilder.build() ..layout(paragraphConstraints);
    canvas.drawParagraph(paragraph, const Offset(10, 10));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
