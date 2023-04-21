import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/Log.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    super.key,
    this.width,
    this.height,
    this.outerBgColor,
    this.innerBgColor,
    this.padding = 0,
  });

  final double? width;
  final double? height;
  final double padding;
  final Color? outerBgColor;
  final Color? innerBgColor;

  @override
  State<StatefulWidget> createState() {
    return MyChatState();
  }
}

class MyChatState extends State<ChatWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Log.d("====MyState=========build========");
    return MultiProvider(
      key: UniqueKey(),
      providers: [
        ChangeNotifierProvider(create: (context) => OnRepaintNotifier()),
      ],
      child: Consumer<OnRepaintNotifier>(builder: (context, OnRepaintNotifier notifier, child) {
        Log.d("========Consumer========");
        return GestureDetector(
          onTapUp: notifier.onTapUp,
          onTapDown: notifier.onTapDown,
          onVerticalDragStart: notifier.onVerticalDragStart,
          onVerticalDragUpdate: notifier.onVerticalDragUpdate,
          onHorizontalDragEnd: notifier.onHorizontalDragEnd,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: widget.width,
              height: widget.height,
              color: widget.outerBgColor,
              child: CustomPaint(
                painter: ChatPainter(context, notifier, this),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ChatPainter extends CustomPainter {
  final Paint _paint = Paint();
  final MyChatState myChatState;
  late ChatWidget widget;

  final BuildContext context;

  final OnRepaintNotifier notifier;

  ChatPainter(this.context, this.notifier, this.myChatState) : super(repaint: notifier) {
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = notifier.stroke;
    widget = myChatState.widget;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect canvasRect = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect contentRect = canvasRect.deflate(widget.padding);
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height)); // 裁剪越界绘制
    // canvas.drawColor(Colors.yellow, BlendMode.src);
    // canvas.translate(notifier.scrolledY, 0);
    if(widget.innerBgColor != null){
      _paint.color = widget.innerBgColor!;
      _paint.style = PaintingStyle.fill;
      canvas.drawRect(contentRect, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class OnRepaintNotifier extends ChangeNotifier {
  OnRepaintNotifier() {
    Log.d("==========OnRepaintNotifier===========");
  }

  double scrolledY = 0;
  double stroke = 8;

  get onTapDown => null;

  void onTapUp(TapUpDetails details) {}

  void onVerticalDragStart(DragStartDetails details) {}

  void onVerticalDragUpdate(DragUpdateDetails details) {}

  void onHorizontalDragEnd(DragEndDetails details) {}
}
