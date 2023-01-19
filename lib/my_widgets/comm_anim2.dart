import 'package:flutter/material.dart';

class CommonTweenAnim<T> {
  CommonTweenAnim();

  void init(
    int milliseconds,
    TickerProvider vsync,
    T begin,
    T end,
  ) {
    _controller = AnimationController(
      duration: Duration(milliseconds: milliseconds),
      reverseDuration: Duration(milliseconds: milliseconds),
      vsync: vsync,
    );
    _tween = Tween<T>(begin: begin, end: end);
    _animation = _tween.animate(controller);
  }

  late AnimationController _controller;
  late Animation<T> _animation;
  late Tween<T> _tween;

  AnimationController get controller => _controller;

  Animation<T>? get animation => _animation;

  Tween<T> get tween => _tween;

  void update(T end, {T? begin}) {
    _tween.begin = begin ?? _animation.value;
    _tween.end = end;
    _animation = _tween.animate(controller);
  }

  void updateEndAndStart(T end) {
    update(end);
    controller.forward(from: 0);
  }

  void addListener(VoidCallback listener) {
    controller.addListener(listener);
  }
}
