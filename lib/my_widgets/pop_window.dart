import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import '../util/Log.dart';
import 'comm_anim2.dart';

class PopWindow {
  MyState? _state;
  late BuildContext context;
  late OverlayEntry entry;
  late Widget child;
  late double contentHeight;

  void _attach(MyState state) {
    _state = state;
  }

  void init(BuildContext context, Widget child, double contentHeight) {
    this.context = context;
    this.child = child;
    this.contentHeight = contentHeight;
  }

  void dismiss() {
    _state?.dismiss();
    entry.remove();
  }

  void show() {
    entry = OverlayEntry(
        builder: (context) => PopPage(
              key: GlobalKey(),
              controller: this,
              contentHeight: contentHeight,
              child: child,
            ));
    Overlay.of(context)?.insert(entry);
  }
}

class PopPage extends StatefulWidget {
  const PopPage({
    super.key,
    this.alignment = Alignment.bottomCenter,
    required this.controller,
    required this.child,
    required this.contentHeight,
  });

  final Alignment alignment;
  final PopWindow controller;
  final Widget child;
  final double contentHeight;

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

  final ColorTween colorTween = ColorTween(begin: const Color(0x00ffffff), end: const Color(0x88000000));
  final ValueNotifier<double> drawerChangeNotifier = ValueNotifier<double>(0);
  double showingContentHeight = 0;
  int state = -1;

  void onAnimUpdate() {
    double animValue = (anim.animation?.value ?? drawerChangeNotifier.value);
    updateState();
    drawerChangeNotifier.value = animValue;
    curBgColor = colorTween.lerp(animValue);
    showingContentHeight = widget.contentHeight * (1 - animValue);
  }

  void updateState() {
    if (anim.controller.isCompleted && state != 1) {
      state = 1;
    } else if (anim.controller.isDismissed && state != -1) {
      state = -1;
    } else {
      state = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller._attach(this);
    BackButtonInterceptor.add(isInterceptor);
    show();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(isInterceptor);
    super.dispose();
  }

  /// true 拦截事件
  bool isInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (state == 1) {
      dismiss();
      return true;
    }
    return false;
  }

  void show() {
    anim.controller.forward(from: 0);
  }

  void dismiss() {
    anim.controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ValueListenableBuilder(
        valueListenable: drawerChangeNotifier,
        builder: (BuildContext context, double value, Widget? child) {
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
                    offset: Offset(0, showingContentHeight),
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
