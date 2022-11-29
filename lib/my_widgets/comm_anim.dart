import 'package:flutter/material.dart';

typedef DoubleCallback = void Function(double d);
typedef ColorCallback = void Function(Color color);
typedef ControllerSettingCallBack = void Function(AnimationController controller);

class CommonValueAnim {
  CommonValueAnim(
    this.listener,
    int milliseconds,
    TickerProvider vsync,
  ) {
    controller = AnimationController(duration: Duration(milliseconds: milliseconds), vsync: vsync);
  }

  void setAnimation(double begin, double end) {
    tween.begin = begin;
    tween.end = end;
    animation = tween.animate(controller);
  }

  setControllerConfig(ControllerSettingCallBack callBack) {
    callBack(controller);
  }

  void setReverseDuring(milliseconds) {
    controller.reverseDuration = Duration(milliseconds: milliseconds);
  }

  late int state = -1; // 1. 表示处于正向动画状态， -1. 表示处于逆向动画状态
  final DoubleCallback listener;
  late AnimationController controller;
  late Tween<double> tween = Tween<double>(begin: 0.0, end: 0.0);
  late Animation<double> animation = tween.animate(controller);

  void stop() {
    controller.stop();
    controller.removeListener(_onUpdate);
  }

  void _onUpdate() {
    listener(animation.value);
  }

  void start(double begin, double end, {double? from = 0}) {
    setAnimation(begin, end);
    controller.addListener(_onUpdate);
    controller.forward(from: from);
    state = 1;
  }

  void stopAndStart(double begin, double end) {
    stop();
    start(begin, end);
  }

  void reverse() {
    controller.reverse();
    state = -1;
  }

  void switchPlay(double begin, double end) {
    if (state == 1) {
      reverse();
    } else {
      start(begin, end, from: null);
    }
  }

  void setDuring(int milliseconds) {
    controller.duration = Duration(milliseconds: milliseconds);
  }
}

class CommonColorAnim {
  CommonColorAnim(
    this.listener,
    int milliseconds,
    Color begin,
    Color end,
    TickerProvider vsync,
  ) {
    controller = AnimationController(duration: Duration(milliseconds: milliseconds), vsync: vsync, reverseDuration: Duration(milliseconds: milliseconds));
    tween = ColorTween(begin: begin, end: end);
    animation = tween.animate(controller);
  }

  final ColorCallback listener;
  late AnimationController controller;
  late ColorTween tween;
  late Animation<Color?> animation;

  void stop() {
    controller.stop();
    controller.removeListener(_onUpdate);
  }

  void _onUpdate() {
    listener(animation.value!);
  }

  void start({from = 0}) {
    animation = tween.animate(controller);
    controller.addListener(_onUpdate);
    controller.forward(from: from);
  }

  void reverseNow() {
    controller.stop();
    controller.reverse();
  }

  Color getColor() {
    return animation.value!;
  }
}
