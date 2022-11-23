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

class _Page extends StatelessWidget {
  const _Page();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comm-Tab"),
      ),
      body: buildContainer(),
    );
  }

  Container buildContainer() {
    Log.d("==========buildContainer===========");
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 300,
            height: 50,
            color: Colors.blue,
            child: Builder(builder: (BuildContext context) {
              return CustomPaint(
                painter: TabPainter(context),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class TabPainter extends CustomPainter {
  final Rect _rect = const Rect.fromLTWH(10, 10, 110, 110);
  final Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  final BuildContext context;
  double tabWidth = 60.0;
  List<String> tabList = [
    "Tab-1",
    "Tab-2",
    "Tab-3",
    "Tab-4",
    "Tab-5",
    "Tab-6",
    "Tab-7",
    "Tab-7",
  ];
  Color bgColor = Colors.grey;

  TabPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Log.d("canvas size:${size.width}  ${size.height}");
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height)); // 裁剪越界绘制
    canvas.drawColor(bgColor, BlendMode.color);
    // 绘制文本

    // canvas.drawRect(_rect, _myPaint);
    for (int i = 0; i < tabList.length; i++) {
      drawText(size, canvas, tabList[i], i);
      _paint.color = i % 2 == 0 ? Colors.red : Colors.blue;
      canvas.drawRect(Rect.fromLTWH(i * tabWidth, 0, tabWidth, size.height), _paint);
    }
  }

  void drawText(Size size, Canvas canvas, String text, int index) {
    var strSize = 12.0;
    Size textSize = measureTextSize(context, text, TextStyle(fontSize: strSize));
    double topOfTabVerticalCenter = (size.height - textSize.height) / 2;
    double leftOfTab = (tabWidth - textSize.width) / 2 + index * tabWidth;
    ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle(fontSize: strSize))..addText(text);
    ParagraphConstraints paragraphConstraints = ParagraphConstraints(width: size.width);
    Paragraph paragraph = paragraphBuilder.build()..layout(paragraphConstraints);
    canvas.drawParagraph(paragraph, Offset(leftOfTab, topOfTabVerticalCenter));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Size measureTextSize(
  BuildContext context,
  String text,
  TextStyle style, {
  int maxLines = 2 ^ 31,
  double maxWidth = double.infinity,
}) {
  if (text.isEmpty) {
    return Size.zero;
  }
  final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      locale: Localizations.localeOf(context),
      text: TextSpan(text: text, style: style),
      maxLines: maxLines)
    ..layout(maxWidth: maxWidth);
  return textPainter.size;
}
