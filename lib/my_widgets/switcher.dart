import 'package:flutter/material.dart';
import 'comm_anim2.dart';

typedef OnListener = void Function(bool isOpen);

class Switcher extends StatefulWidget {
  const Switcher({
    super.key,
    required this.thumbAttr,
    required this.barAttr,
    this.isOpen = false,
    this.horizontalPadding = 0,
    required this.onListener,
    this.middleLayerWidget,
  });

  final SwitcherAttr thumbAttr;
  final SwitcherAttr barAttr;
  final double horizontalPadding;
  final bool isOpen;
  final OnListener onListener;
  final Widget? middleLayerWidget;

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<Switcher> with TickerProviderStateMixin {
  /// 左边是关闭状态，右边是打开状态
  late bool isOpenOnInit = widget.isOpen;
  late int state = widget.isOpen ? 1 : -1;
  final double start = 0.0; // 关闭状态
  final double end = 1.0; // 打开状态
  late CommonTweenAnim<double> amin = CommonTweenAnim<double>()
    ..init(200, this, start, end)
    ..addListener(onAnimUpdate);

  late double curAnimValue = isOpenOnInit ? end : start;
  late final ValueNotifier<double> notifier = ValueNotifier<double>(curAnimValue);

  void onAnimUpdate() {
    curAnimValue = amin.animation?.value ?? 0;
    notifier.value = curAnimValue;
    if (amin.controller.isCompleted && state != 1) {
      state = 1;
      widget.onListener(true);
    } else if (amin.controller.isDismissed && state != -1) {
      state = -1;
      widget.onListener(false);
    } else {
      state = 0;
    }
  }

  void switchState() {
    if (state == 1) {
      amin.controller.reverse(from: end);
    } else if (state == -1) {
      amin.controller.forward(from: start);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => switchState(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.barAttr.radius),
        child: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (BuildContext context, double value, Widget? child) {
            double maxThumbLeftMargin = widget.barAttr.width - widget.thumbAttr.width - widget.horizontalPadding;
            double minThumbLeftMargin = widget.horizontalPadding;
            double curThumbLeftMargin = minThumbLeftMargin + curAnimValue * (maxThumbLeftMargin - minThumbLeftMargin);
            return Container(
              alignment: Alignment.centerLeft,
              width: widget.barAttr.width,
              height: widget.barAttr.height,
              color: widget.barAttr.colorTween.lerp(curAnimValue),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(left: 0, child: widget.middleLayerWidget ?? const SizedBox()),
                  Positioned(
                      left: curThumbLeftMargin,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(widget.thumbAttr.radius),
                        child: Container(
                          width: widget.thumbAttr.width,
                          height: widget.thumbAttr.height,
                          color: widget.thumbAttr.colorTween.lerp(curAnimValue),
                        ),
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SwitcherAttr {
  final double width;
  final double height;
  final double radius;
  late ColorTween colorTween;

  SwitcherAttr({
    required this.width,
    required this.height,
    required this.radius,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    colorTween = ColorTween(begin: unselectedColor, end: selectedColor);
  }
}
