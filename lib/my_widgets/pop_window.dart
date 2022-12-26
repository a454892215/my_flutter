import 'package:flutter/material.dart';

import 'comm_anim2.dart';

class PopWindow {
  MyState? _state;
  late BuildContext context;
  OverlayEntry? entry;
  late double bottomWidgetHeight;
  late Widget child;

  void _attach(MyState state) {
    _state = state;
  }

  void init(BuildContext context, double bottomWidgetHeight, Widget child) {
    this.context = context;
    this.bottomWidgetHeight = bottomWidgetHeight;
    this.child = child;
  }

  void dismiss() {
    _state?.startDismissAnim();
  }

  void destroy() {
    entry!.remove();
    print("=======destroy=======");
  }

  void show() {
    if (entry != null && entry!.mounted) {
      print("=======mounted=======");
      _state?.startShowAnim();
    } else {
      print("====not===mounted=======");
      entry = OverlayEntry(
          builder: (context) => PopPage(
                key: GlobalKey(),
                controller: this,
                bottomWidgetHeight: bottomWidgetHeight,
                child: child,
              ));
      Overlay.of(context)?.insert(entry!);
    }
  }
}

class PopPage extends StatefulWidget {
  const PopPage({super.key, this.alignment = Alignment.bottomCenter, required this.controller, required this.bottomWidgetHeight, required this.child});

  final Alignment alignment;
  final PopWindow controller;
  final double bottomWidgetHeight;
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<PopPage> with TickerProviderStateMixin {
  late CommonTweenAnim<double> anim = CommonTweenAnim<double>()
    ..init(200, this, 0.0, 1.0)
    ..addListener(onAnimUpdate);
  Color? curBgColor;
  late int state = -1;
  final ValueNotifier<double> drawerChangeNotifier = ValueNotifier<double>(0);
  final ColorTween colorTween = ColorTween(begin: const Color(0x00ffffff), end: const Color(0x88000000));
  late double translateY = widget.bottomWidgetHeight;

  void onAnimUpdate() {
    double animValue = (anim.animation?.value ?? drawerChangeNotifier.value);
    if (anim.controller.isCompleted && state != 1) {
      state = 1;
    } else if (anim.controller.isDismissed && state != -1) {
      state = -1;
      onDismissed();
    } else {
      state = 0;
    }
    drawerChangeNotifier.value = animValue;
    curBgColor = colorTween.lerp(animValue);
    translateY = widget.bottomWidgetHeight * (1.0 - animValue);
  }

  void onDismissed() {
    // widget.controller.destroy();
  }

  @override
  void initState() {
    super.initState();
    widget.controller._attach(this);
    startShowAnim();
  }

  void startShowAnim() {
    anim.controller.forward(from: 0);
  }

  void startDismissAnim() {
    anim.controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.controller.dismiss();
      },
      child: ValueListenableBuilder(
        valueListenable: drawerChangeNotifier,
        builder: (BuildContext context, double value, Widget? child) {
          print("state:  $state =======");
          return Offstage(
            offstage: state == -1,
            child: Material(
              color: Colors.transparent,
              child: Container(
                color: curBgColor,
                alignment: widget.alignment,
                child: GestureDetector(
                  onTap: () {},
                  child: Transform.translate(
                    offset: Offset(0, translateY),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
