import 'package:flutter/material.dart';

import '../util/Log.dart';
import 'comm_anim2.dart';
import 'my_physics.dart';
import 'dart:math' as math;

void main() {}

class Refresher extends StatefulWidget {
  const Refresher({
    super.key,
    required this.child,
    required this.sc,
    required this.height,
    required this.width,
  });

  final Widget child;
  final ScrollController sc;
  final double height;
  final double width;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<Refresher> with TickerProviderStateMixin {
  late ScrollController sc = widget.sc;
  static double headerHeight = 180;

  late final ValueNotifier<double> notifier = ValueNotifier<double>(-headerHeight);

  late CommonTweenAnim<double> anim = CommonTweenAnim<double>()
    ..init(200, this, 0, 1)
    ..addListener(onAnimUpdate);
  int state = 0;

  void onAnimUpdate() {
    notifier.value = anim.animation?.value ?? -headerHeight;
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
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (a, b, c) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: OverflowBox(
            alignment: Alignment.topLeft,
            maxHeight: widget.height * 3,
            child: _buildContent(),
          ),
        );
      },
    );
  }

  ///  offset: Offset(0, notifier.value),
  Widget _buildContent() {
    return ClipRRect(
      child: Transform.translate(
        offset: Offset(0, notifier.value),
        child: Column(
          children: [
            _buildHeader(),
            Listener(
              onPointerMove: onPointerMove,
              onPointerUp: onPointerUp,
              onPointerCancel: onPointerCancel,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: headerHeight,
      color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: Colors.yellow,
            height: 40,
            width: widget.width,
          ),
          Container(
            color: Colors.red,
            height: 40,
            width: widget.width,
          ),
          Container(
            color: Colors.blue,
            height: 40,
            width: widget.width,
          ),
        ],
      ),
    );
  }

  double max = 0;
  double min = double.maxFinite;
  double pixels = 0;

  void onPointerUp(PointerUpEvent event) {
    if (max > 0 && pixels >= max && notifier.value > -headerHeight) {
      anim.update(-headerHeight, begin: notifier.value);
      anim.controller.forward(from: 0);
      Log.d("播放头部收回动画: ${anim.controller.value} ${anim.animation?.value}  ${notifier.value}");
    } else {
      Log.d("头部收回动画条件不满足：");
    }
  }

  void onPointerCancel(PointerCancelEvent event) {
    Log.d("========onPointerCancel======：");
  }

  void onPointerMove(PointerMoveEvent e) {
    ScrollPosition position = sc.position;
    max = position.maxScrollExtent;
    min = position.minScrollExtent;
    pixels = position.pixels;
    double newValue = notifier.value + e.delta.dy;
    MyClampingScrollPhysics physics = sc.position.physics as MyClampingScrollPhysics;
    //header scroll
    if (pixels >= max) {
      if (e.delta.dy > 0) {
        // header 向下滑动
        physics.scrollEnable = false;

        /// scrolledHeaderY = 0;
        double scrolledHeaderY = headerHeight + notifier.value;
        double scrolledRate = scrolledHeaderY / headerHeight;
        newValue = notifier.value + (e.delta.dy * (1 - scrolledRate));
        if (newValue > 0) newValue = 0;
        notifier.value = newValue;
      //  Log.d("header 向下滑动 越界滑动状态 :  ${e.delta}  max:$max   pixels:$pixels  newValue:$newValue  rate:$scrolledRate");
      } else if (e.delta.dy < 0) {
        // header 向上滑动
        physics.scrollEnable = false;
        if (newValue < -headerHeight) newValue = -headerHeight;
        notifier.value = newValue;
        Log.d("header 向上滑动 :  ${e.delta}  max:$max   min:$min  newValue:$newValue");
      }
    } else if (pixels <= min) {
    } else {
      physics.scrollEnable = true;
    }
    Log.d("pixels:$pixels  max:$max");
  }
}
