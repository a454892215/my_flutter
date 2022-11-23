import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../util/Log.dart';

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
            child: _buildCommonTab(),
          ),
        ],
      ),
    );
  }

  CommonTab _buildCommonTab() {
    List<dynamic> tabList = [];
    for (int i = 0; i < 12; i++) {
      tabList.add("Tab-$i");
    }
    return CommonTab(tabList: tabList, width: 300);
  }
}

class CommonTab extends StatelessWidget {
  const CommonTab({
    super.key,
    this.fontSize = 12,
    this.selectedFontSize = 12,
    this.fontColor = Colors.black,
    this.selectedFontColor = Colors.white,
    this.indicatorColor = Colors.blue,
    this.indicatorWidth = 0,
    this.indicatorHeight = 2,
    this.tabWidth = 60,
    required this.tabList,
    required this.width,
  });

  final double fontSize;
  final double selectedFontSize;

  final Color fontColor;
  final Color selectedFontColor;

  final Color indicatorColor;
  final double indicatorWidth;
  final double indicatorHeight;

  final double tabWidth;
  final List<dynamic> tabList;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OnRepaintNotifier(this, tabList)),
        ],
        child: Consumer<OnRepaintNotifier>(builder: (context, OnRepaintNotifier notifier, child) {
          return GestureDetector(
            onTap: notifier.onTap,
            onHorizontalDragUpdate: notifier.onHorizontalDragUpdate,
            child: CustomPaint(
              painter: TabPainter(context, notifier),
            ),
          );
        }),
      );
    });
  }
}

class OnRepaintNotifier extends ChangeNotifier {
  double scrolledX = 0;
  double fontSize = 12.0;
  late double tabWidth;
  late int tabCount;
  final CommonTab commonTab;
  final List<dynamic> tabList;

  OnRepaintNotifier(this.commonTab, this.tabList) {
    tabWidth = commonTab.tabWidth;
    tabCount = tabList.length;
  }

  void onTap() {
    Log.d("======onTap=========");
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    scrolledX += details.delta.dx;
    double maxCanScrollDx = -(tabWidth * tabCount - commonTab.width);
    scrolledX = scrolledX > 0 ? 0 : scrolledX;
    scrolledX = scrolledX < maxCanScrollDx ? maxCanScrollDx : scrolledX;
    notifyListeners();
    Log.d("======onHorizontalDragUpdate=========dx: $scrolledX");
  }
}

class TabPainter extends CustomPainter {
  final Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = stroke;

  static const double stroke = 1;
  final BuildContext context;

  Color bgColor = Colors.grey;
  final OnRepaintNotifier notifier;

  TabPainter(this.context, this.notifier) : super(repaint: notifier);

  @override
  void paint(Canvas canvas, Size size) {
    // Log.d("canvas size:${size.width}  ${size.height}");
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height)); // 裁剪越界绘制
    canvas.translate(notifier.scrolledX, 0);
    canvas.drawColor(bgColor, BlendMode.color);
    for (int i = 0; i < notifier.tabList.length; i++) {
      drawText(size, canvas, notifier.tabList[i].toString(), i);
      _paint.color = i % 2 == 0 ? Colors.red : Colors.blue;
      double widthInBorder = notifier.tabWidth - stroke;
      canvas.drawRect(Rect.fromLTWH(i * notifier.tabWidth, 0, widthInBorder, size.height), _paint);
    }
  }

  void drawText(Size size, Canvas canvas, String text, int index) {
    Size textSize = measureTextSize(context, text, TextStyle(fontSize: notifier.fontSize));
    double topOfTabVerticalCenter = (size.height - textSize.height) / 2;
    double leftOfTab = (notifier.tabWidth - textSize.width) / 2 + index * notifier.tabWidth;
    ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle(fontSize: notifier.fontSize))..addText(text);
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
