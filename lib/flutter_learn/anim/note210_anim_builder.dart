import 'package:flutter/material.dart';

main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: AnimatedBuilderSample(),
    ),
  ));
}

///1. ColorTween
class AnimatedBuilderSample extends StatefulWidget {
  const AnimatedBuilderSample({Key? key}) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State with SingleTickerProviderStateMixin {
  /// forward(from: 1) UI初始化完毕 显示的是动画末尾的状态
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 3000))..forward(from: 1);

  late final Animation<double> _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},

      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: _animation.value,
            child: child,
          );
        },
        child: InkWell(
          onTap: () {
            _controller.forward(from: 0);
          },
          child: Container(
            color: Colors.blue,
            width: 160,
            height: 160,
          ),
        ),
      ),
    );
  }
}
