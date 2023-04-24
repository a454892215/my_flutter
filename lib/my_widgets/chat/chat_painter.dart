import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../util/Log.dart';
import 'entities.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    super.key,
    this.width,
    this.height,
    this.outerBgColor,
    this.innerBgColor,
    this.padding = 0,
    required this.list,
  });

  final double? width;
  final double? height;
  final double padding;
  final Color? outerBgColor;
  final Color? innerBgColor;
  final List<ChatMessage> list;

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
        ChangeNotifierProvider(create: (context) => ChatRepaintNotifier()),
      ],
      child: Consumer<ChatRepaintNotifier>(builder: (context, ChatRepaintNotifier notifier, child) {
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
                painter: ChatPainter(context, notifier, this, widget.list),
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

  final ChatRepaintNotifier notifier;
  final List<ChatMessage> list;

  ChatPainter(this.context, this.notifier, this.myChatState, this.list) : super(repaint: notifier) {
    Log.d("==========ChatPainter 构造函数调用===================");
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = notifier.stroke;
    widget = myChatState.widget;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect canvasRect = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect contentRect = canvasRect.deflate(widget.padding);
    Log.d("================paint======================");
    // canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height)); // 裁剪越界绘制
    // canvas.drawColor(Colors.yellow, BlendMode.src);
    // canvas.translate(notifier.scrolledY, 0);
    if (widget.innerBgColor != null) {
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

class ChatRepaintNotifier extends ChangeNotifier {
  ChatRepaintNotifier() {
    Log.d("============OnRepaintNotifier 构造函数调用=============");
  }

  double scrolledY = 0;
  double stroke = 8;

  void onTapUp(TapUpDetails details) {}

  void onVerticalDragStart(DragStartDetails details) {}

  void onVerticalDragUpdate(DragUpdateDetails details) {}

  void onHorizontalDragEnd(DragEndDetails details) {}

  void onTapDown(TapDownDetails details) {}
}

class ChatController {
  void notifyRefresh() {}
}
