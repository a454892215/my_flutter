import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: ScaleTransitionSample(),
    ),
  ));
}

///1. RotationTransition
class ScaleTransitionSample extends StatefulWidget {
  const ScaleTransitionSample({Key? key}) : super(key: key);

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

  late final Animation<double> _animation = Tween<double>(begin: 0.3, end: 1).animate(_controller);

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
    return GestureDetector(onTap: (){
      // 不传入0 动画不能重置只能执行一次,
      _controller.forward(from: 0);
      Toast.show("播放缩放动画");
    },child: Center(
      child: Container(
        width: 200,
        height: 100,
        color: Colors.orange,
        alignment: Alignment.topLeft,
        child: ScaleTransition(
          /// 设置缩放中心
          alignment: Alignment.center,
          scale: _animation,
          child: Container(
            width: 200,
            height: 100,
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text("播放缩放动画", style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    ),);
  }
}
