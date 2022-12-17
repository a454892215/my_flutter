import 'package:flutter/material.dart';

import 'comm_anim2.dart';

class BottomDrawer extends StatefulWidget {
  const BottomDrawer({
    super.key,
    required this.child,
    required this.height,
    required this.controller,
    required this.maxWidth,
    required this.maxHeight,
  });

  final Widget child;
  final double height;
  final double maxWidth;
  final double maxHeight;
  final DrawerController2 controller;

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<BottomDrawer> with TickerProviderStateMixin {
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

  int openState = -1;

  void onHeightUpdate() {
    contentHeightNotifier.value = heightAnim.animation?.value ?? contentHeightNotifier.value;
    if (heightAnim.controller.isCompleted) {
      openState = 1;
    } else if (heightAnim.controller.isDismissed && openState != -1) {
      openState = -1;
    } else {
      openState = 0;
    }
  }

  void show() {
    heightAnim.controller.forward(from: 0);
  }

  void dismiss() {
    heightAnim.controller.reverse();
  }

  void showOrDismiss() {
    if (openState == -1) {
      show();
    } else if (openState == 1) {
      dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: widget.maxWidth,
      height: widget.maxHeight,
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
  }
}

class DrawerController2 {
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

  void showOrDismiss() {
    _state!.showOrDismiss();
  }
}
