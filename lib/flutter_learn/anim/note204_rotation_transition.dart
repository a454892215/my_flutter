import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/comm_anim.dart';

import '../../util/toast_util.dart';

main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: RotationTransitionSample(),
    ),
  ));
}

///1. RotationTransition
class RotationTransitionSample extends StatefulWidget {
  const RotationTransitionSample({Key? key}) : super(key: key);

  @override
  State createState() => _SizeTransitionDemoState();
}

class _SizeTransitionDemoState extends State with TickerProviderStateMixin {
  late CommonValueAnim valueAnim = CommonValueAnim((d) {}, 1000, this)..setReverseDuring(1000)
    ..start(0.0, 0.5);

  @override
  void initState() {
    // _controller.addListener(() {
    //   if (_controller.isCompleted) {
    //     _controller.reset();
    //     /// 重置
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 100,
        color: Colors.orange,
        alignment: Alignment.topLeft,
        child: RotationTransition(
          /// 设置旋转中心
          alignment: Alignment.center,
          turns: valueAnim.animation,
          child: Container(
            width: 200,
            height: 100,
            color: Colors.blue,
            child: TextButton(
              onPressed: () {
                /// 1. 0.5表示旋转180度：即360 * 0.5 = 180
                valueAnim.switchPlay(0, 0.5);
              },
              child: const Text(
                "播放旋转动画",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
