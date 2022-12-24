import 'package:flutter/material.dart';

import 'comm_anim2.dart';

class PopWindow {
  MyState? _state;
  late BuildContext context;
  late OverlayEntry entry;

  void _attach(MyState state) {
    _state = state;
  }

  void init(BuildContext context) {
    this.context = context;
  }

  void dismiss() {
    _state?.dismiss();
    entry.remove();
  }

  void show() {
    entry = OverlayEntry(builder: (context) => PopPage(key: GlobalKey(), controller: this));
    Overlay.of(context)?.insert(entry);
  }
}

class PopPage extends StatefulWidget {
  const PopPage({super.key, this.alignment = Alignment.bottomCenter, required this.controller});

  final Alignment alignment;
  final PopWindow controller;

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

  final ValueNotifier<double> drawerChangeNotifier = ValueNotifier<double>(0);

  void onAnimUpdate() {
    double animValue = (anim.animation?.value ?? drawerChangeNotifier.value);
    drawerChangeNotifier.value = animValue;
    curBgColor = colorTween.lerp(animValue);
  }

  @override
  void initState() {
    super.initState();
    widget.controller._attach(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      show();
    });
  }

  void show() {
    anim.controller.forward(from: 0);
  }

  void dismiss() {
    anim.controller.reverse();
  }

  final ColorTween colorTween = ColorTween(begin: const Color(0x00ffffff), end: const Color(0x88000000));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: drawerChangeNotifier,
          builder: (BuildContext context, double value, Widget? child) {
            return Container(
              color: curBgColor,
              alignment: widget.alignment,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 300,
                  height: 200,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text("内容"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
