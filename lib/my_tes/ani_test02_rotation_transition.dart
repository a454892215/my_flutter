import 'package:flutter/material.dart';

main() {
  runApp(const MaterialApp(
    home: RotationTransitionDemo(),
  ));
}

class RotationTransitionDemo extends StatefulWidget {
  const RotationTransitionDemo({Key? key}) : super(key: key);

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

  /// 1. 0.5表示旋转180度：即360 * 0.5 = 180
  late final Animation<double> _animation = Tween<double>(begin: 0, end: 0.5).animate(_controller);

  @override
  void initState() {
    _controller.addListener(() {
      if(_controller.isCompleted){
        _controller.reset(); /// 重置
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // 不传入0 动画不能重置只能执行一次,
            _controller.forward(from: 0);
          });
        },
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 100,
          color: Colors.orange,
          alignment: Alignment.topLeft,
          child: RotationTransition(
            turns: _animation,
            child: Container(
              width: 200,
              height: 100,
              color: Colors.blue,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    // 不传入0 动画不能重置只能执行一次,
                    _controller.forward(from: 0);
                  });
                },
                child: const Text("点击播放", style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
