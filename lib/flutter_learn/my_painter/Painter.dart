import 'dart:ui';

import 'package:flutter/material.dart';

import '../../util/Log.dart';
String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: _Page(),
  ));
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text("按钮"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              child: CustomPaint(
                painter: MyPainter1(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPainter1 extends CustomPainter {
  final Rect _rect = const Rect.fromLTWH(10, 10, 110, 110);
  final Paint _myPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5;

  @override
  void paint(Canvas canvas, Size size) {
    Log.d("size:$size");
    canvas.drawRect(_rect, _myPaint);
    // 绘制文本
    drawTextSample(size, canvas);
  }

  void drawTextSample(Size size, Canvas canvas) {
    // 绘制文本
    ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle(fontSize: 16))..addText('Hello World');
    ParagraphConstraints paragraphConstraints = ParagraphConstraints(width: size.width);
    Paragraph paragraph = paragraphBuilder.build() ..layout(paragraphConstraints);
    canvas.drawParagraph(paragraph, const Offset(10, 10));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
