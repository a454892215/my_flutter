import 'package:flutter/material.dart';

typedef DoubleCallback = void Function(double d);

class CommonValueAnim {
  CommonValueAnim(
    this.listener,
    int milliseconds,
    TickerProvider vsync,
  ) {
    controller = AnimationController(duration: Duration(milliseconds: milliseconds), vsync: vsync);
  }

  final DoubleCallback listener;
  late AnimationController controller;
  late Tween<double> tween = Tween<double>(begin: 0.0, end: 0.0);
  late Animation<double> animation;

  void stop() {
    controller.stop();
    controller.removeListener(_onUpdate);
  }

  void _onUpdate() {
    listener(animation.value);
  }

  void start(double begin, double end) {
    tween.begin = begin;
    tween.end = end;
    animation = tween.animate(controller);
    controller.addListener(_onUpdate);
    controller.forward(from: 0);
  }
}
