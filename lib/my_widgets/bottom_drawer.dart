import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'comm_anim2.dart';

class BottomDrawer extends StatefulWidget {
  const BottomDrawer({
    super.key,
    required this.child,
    required this.height,
    required this.controller,
    this.outClickDismiss = true,
  });

  final Widget child;
  final double height;
  final DrawerController2 controller;
  final bool outClickDismiss;

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<BottomDrawer> with TickerProviderStateMixin {
  final ValueNotifier<double> drawerChangeNotifier = ValueNotifier<double>(0);
  double contentHeight = 0;
  double bgHeight = 0;
  late CommonTweenAnim<double> anim = CommonTweenAnim<double>()
    ..init(200, this, 0.0, 1.0)
    ..addListener(onHeightUpdate);

  final ColorTween colorTween = ColorTween(begin: const Color(0x00ffffff), end: const Color(0x88000000));
  Color? curBgColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    widget.controller.attach(this);
  }

  int openState = -1;

  void onHeightUpdate() {
    if (anim.animation?.status == AnimationStatus.forward && anim.animation?.value == 0) {
      onPrepareOpenDrawer();
    }
    if (anim.controller.isCompleted) {
      onOpenedDrawer();
    } else if (anim.controller.isDismissed && openState != -1) {
      onClosedDrawer();
    } else {
      openState = 0;
    }
    double animValue = (anim.animation?.value ?? drawerChangeNotifier.value);
    drawerChangeNotifier.value = animValue;
    curBgColor = colorTween.lerp(animValue);
    contentHeight = animValue * widget.height;
  }

  onPrepareOpenDrawer() {
    bgHeight = 1.sh;
  }

  onOpenedDrawer() {
    openState = 1;
  }

  onClosedDrawer() {
    openState = -1;
    bgHeight = 0;
  }

  void show() {
    anim.controller.forward(from: 0);
  }

  void dismiss() {
    anim.controller.reverse();
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
    return GestureDetector(
      onTap: () {
        if (widget.outClickDismiss) {
          dismiss();
        }
      },
      child: ValueListenableBuilder(
        valueListenable: drawerChangeNotifier,
        builder: (BuildContext context, double value, Widget? child) {
          return Container(
            alignment: Alignment.bottomCenter,
            width: 1.sw,
            height: bgHeight,
            color: curBgColor,
            child: GestureDetector(
              onTap: () {},
              child: SizedBox(
                width: widget.height,
                height: contentHeight,
                child: FittedBox(fit: BoxFit.cover, clipBehavior: Clip.hardEdge, child: widget.child),
              ),
            ),
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
    _state?.dismiss();
  }

  void showOrDismiss() {
    _state?.showOrDismiss();
  }
}
