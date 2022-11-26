import 'package:flutter/material.dart';

typedef DoubleCallback = void Function(double d);
typedef ColorCallback = void Function(Color color);

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

  void stopAndStart(double begin, double end){
    stop();
    start(begin, end);
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
    controller = AnimationController(
        duration: Duration(milliseconds: milliseconds), vsync: vsync, reverseDuration: Duration(milliseconds: milliseconds));
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

  void start() {
    animation = tween.animate(controller);
    controller.addListener(_onUpdate);
    controller.forward(from: 0);
  }

  void reverseNow() {
    controller.reverse();
  }

  Color getColor() {
    return animation.value!;
  }
}
