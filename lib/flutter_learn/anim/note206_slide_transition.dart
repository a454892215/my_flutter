import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: SlideTransitionSample(),
    ),
  ));
}

///1. SlideTransition
class SlideTransitionSample extends StatefulWidget {
  const SlideTransitionSample({Key? key}) : super(key: key);

  @override
  State createState() => _SizeTransitionDemoState();
}

class _SizeTransitionDemoState extends State with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 2000),
    reverseDuration: const Duration(milliseconds: 2000),
    animationBehavior: AnimationBehavior.preserve,
    vsync: this,
  )..reset();

  late final Animation<Offset> _animation =
  /// Offset: 0.5移动的距离是父窗口长度的一半，以此类推
      Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.5, 0.5)).animate(_controller);

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.isCompleted) {
        // _controller.reset();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 不传入0 动画不能重置只能执行一次,
        _controller.forward(from: 0);
        Toast.show("SlideTransition");
      },
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.orange,
          alignment: Alignment.topLeft,
          child: SlideTransition(
            position: _animation,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text(
                  "SlideTransition",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
