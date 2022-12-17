import 'package:flutter/material.dart';

import 'comm_anim2.dart';

class BottomDialog extends StatefulWidget {
  const BottomDialog({
    super.key,
    required this.child,
    required this.height,
    required this.controller,
  });

  final Widget child;
  final double height;
  final DialogController controller;

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<BottomDialog> with TickerProviderStateMixin {
  final ValueNotifier<double> contentHeightNotifier = ValueNotifier<double>(0);
  final ValueNotifier<double> bgHeightNotifier = ValueNotifier<double>(0);
  late CommonTweenAnim<double> heightAnim = CommonTweenAnim<double>()
    ..init(200, this, 0.0, widget.height)
    ..addListener(onHeightUpdate);

  @override
  void initState() {
    super.initState();
    widget.controller.attach(this);
  }

  void onHeightUpdate() {
    contentHeightNotifier.value = heightAnim.animation?.value ?? contentHeightNotifier.value;
    if (heightAnim.controller.isCompleted) {
      if (contentHeightNotifier.value == widget.height) {
        print("======dialog opened =====");
      } else if (contentHeightNotifier.value == 0) {
        print("======dialog closed =====");
      }
    }
  }

  void show() {
    heightAnim.controller.forward(from: 0);
  }

  void dismiss() {
    heightAnim.controller.reverse(from: 1);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraintType) {
      print('==========maxWidth: ${constraintType.maxWidth} maxWidth : ${constraintType.maxHeight}===========');
      return Container(
        alignment: Alignment.bottomCenter,
        width: constraintType.maxWidth,
        height: constraintType.maxHeight,
        color: Colors.black54,
        child: ValueListenableBuilder(
          valueListenable: contentHeightNotifier,
          builder: (BuildContext context, double value, Widget? child) {
            //  print("===ValueListenableBuilder=${heightNotifier.value}===");
            return SizedBox(
              width: widget.height,
              height: contentHeightNotifier.value,
              child: FittedBox(fit: BoxFit.cover, clipBehavior: Clip.hardEdge, child: widget.child),
            );
          },
        ),
      );
    });
  }
}

class DialogController {
  MyState? _state;

  void attach(MyState state) {
    _state = state;
  }

  void show() {
    _state?.show();
  }

  void dismiss() {
    _state!.dismiss();
  }
}
