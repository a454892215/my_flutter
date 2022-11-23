//import 'dart:ui';

import 'dart:ui' as ui;

import 'package:my_flutter_lib_3/util/toast_util.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../util/Log.dart';
import '../util/math_util.dart';

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
    return CommonTab(
      tabList: tabList,
      width: 300,
      height: 50,
    );
  }
}

class CommonTab extends StatefulWidget {
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
    required this.height,
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
  final double height;

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<CommonTab> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OnRepaintNotifier(widget, widget.tabList, this)),
        ],
        child: Consumer<OnRepaintNotifier>(builder: (context, OnRepaintNotifier notifier, child) {
          return GestureDetector(
            onTapUp: notifier.onTapUp,
            onTapDown: notifier.onTapDown,
            onPanDown: notifier.onPanDown,
            onHorizontalDragUpdate: notifier.onHorizontalDragUpdate,
            onHorizontalDragEnd: notifier.onHorizontalDragEnd,
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
  late double tabWidth;
  late int tabCount;
  final CommonTab commonTab;
  final List<dynamic> tabList;
  final MyState commonTabState;
  late double maxCanScrollDx = 0;
  Color pressColor = const Color(0x33000000);
  late Rect pressedArea = const Rect.fromLTWH(0, 0, 0, 0);
  late int curPressedIndex;
  late int curSelectedIndex = 0;
  double stroke = 5;

  OnRepaintNotifier(this.commonTab, this.tabList, this.commonTabState) {
    tabWidth = commonTab.tabWidth;
    tabCount = tabList.length;
  }

  late AnimationController jumpController =
      AnimationController(duration: const Duration(milliseconds: 300), vsync: commonTabState);
  late Animation<double> jumpAnim = Tween<double>(begin: 0.0, end: 0.0).animate(jumpController);

  void onTapUp(TapUpDetails details) {
    int curTimestamp = DateTime.now().millisecondsSinceEpoch;
    int dTime = curTimestamp - pressTimestamp;
    if (dTime > 500) {
      return;
    }
    double realClickLocationX = details.localPosition.dx + scrolledX.abs();
    curSelectedIndex = realClickLocationX ~/ tabWidth;
    double x = curSelectedIndex * tabWidth + scrolledX;
    double dxTabLeftToCenterOfSelectedItem = commonTab.width / 2.0 - x - tabWidth / 2.0;
    Toast.show("dxToCenterOfSelectedItem: $dxTabLeftToCenterOfSelectedItem");
    jumpController.stop();
    jumpController.removeListener(onScroll);
    jumpAnim = Tween<double>(begin: scrolledX, end:scrolledX + dxTabLeftToCenterOfSelectedItem).animate(jumpController);
    jumpController.addListener(onScroll);
    jumpController.forward(from: 0);
    notifyListeners();
  }

  void onScroll(){
     scrollTo(jumpAnim.value);
  }

  late int pressTimestamp;

  void onTapDown(TapDownDetails details) {
    pressTimestamp = DateTime.now().millisecondsSinceEpoch;
    double realClickLocationX = details.localPosition.dx + scrolledX.abs();
    curPressedIndex = realClickLocationX ~/ tabWidth;
    pressedArea = Rect.fromLTWH(curPressedIndex * tabWidth, 0, tabWidth, commonTab.height);
    //Toast.show("index: $curPressedIndex ");
  }

  void onPanDown(DragDownDetails details) {}

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    scrolledX += details.delta.dx;
    limitMaxScrollX();
    notifyListeners();
  }

  void limitMaxScrollX() {
    maxCanScrollDx = -(tabWidth * tabCount - commonTab.width);
    scrolledX = scrolledX > 0 ? 0 : scrolledX;
    scrolledX = scrolledX < maxCanScrollDx ? maxCanScrollDx : scrolledX;
  }

  late AnimationController flingController = AnimationController(vsync: commonTabState);
  late Animation<double> flingAnim = Tween<double>(begin: 0.0, end: 0.0).animate(flingController);

  void onFling() {
    scrolledX += flingAnim.value;
    limitMaxScrollX();
    notifyListeners();
  }

  void scrollTo(double tarX) {
    scrolledX = tarX;
    limitMaxScrollX();
    notifyListeners();
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    flingController.stop();
    flingController.removeListener(onFling);
    double xSpeed = details.velocity.pixelsPerSecond.dx / 60;
    int during = MathU.clamp(xSpeed.abs() * 30, 200.0, 2000.0).toInt();
    flingController.duration = Duration(milliseconds: during);
    // Log.d("during: $during   xSpeed: $xSpeed");
    flingAnim = Tween<double>(begin: xSpeed, end: 0.0).animate(flingController);
    flingController.addListener(onFling);
    flingController.forward(from: 0);
  }
}

class TabPainter extends CustomPainter {
  late Paint _paint;

  final BuildContext context;

  final OnRepaintNotifier notifier;

  TabPainter(this.context, this.notifier) : super(repaint: notifier) {
    _paint = Paint();
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = notifier.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Log.d("canvas size:${size.width}  ${size.height}");
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height)); // 裁剪越界绘制
    canvas.translate(notifier.scrolledX, 0);
    // canvas.drawRect(notifier.pressedArea, _paint);
    for (int i = 0; i < notifier.tabList.length; i++) {
      drawText(size, canvas, notifier.tabList[i].toString(), i);
      // drawStrokeBorder(i, size, canvas);
    }
  }

  void drawStrokeBorder(int i, Size size, Canvas canvas) {
    _paint.color = i % 2 == 0 ? Colors.red : Colors.blue;
    double left = i * notifier.tabWidth + notifier.stroke / 2.0;
    double width = notifier.tabWidth - notifier.stroke;
    double height = size.height - notifier.stroke;
    canvas.drawRect(Rect.fromLTWH(left, notifier.stroke / 2.0, width, height), _paint);
  }

  void drawText(Size size, Canvas canvas, String text, int index) {
    var fontColor = notifier.commonTab.fontColor;
    var fontSize = notifier.commonTab.fontSize;
    if (notifier.curSelectedIndex == index) {
      fontColor = notifier.commonTab.selectedFontColor;
      fontSize = notifier.commonTab.selectedFontSize;
    }
    Size textSize = measureTextSize(context, text, TextStyle(fontSize: fontSize));
    double topOfTabVerticalCenter = (size.height - textSize.height) / 2;
    double leftOfTab = (notifier.tabWidth - textSize.width) / 2 + index * notifier.tabWidth;
    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle())
      ..pushStyle(ui.TextStyle(fontSize: fontSize, color: fontColor))
      ..addText(text);
    ui.ParagraphConstraints paragraphConstraints = ui.ParagraphConstraints(width: size.width);
    ui.Paragraph paragraph = paragraphBuilder.build()..layout(paragraphConstraints);
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
