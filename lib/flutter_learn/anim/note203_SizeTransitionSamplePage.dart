import 'package:flutter/material.dart';

import '../../util/Log.dart';
import '../../util/toast_util.dart';

/// 1. SizeTransition
class SizeTransitionSamplePage extends StatefulWidget {
  const SizeTransitionSamplePage({Key? key}) : super(key: key);

  @override
  State createState() => _SizeTransitionDemoState();
}

class _SizeTransitionDemoState extends State with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    //
    duration: const Duration(milliseconds: 1000),
    reverseDuration: const Duration(milliseconds: 2000),
    animationBehavior: AnimationBehavior.preserve,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
     setState(() {
       _controller.forward(from: 0);
     });
    }, child: Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.orange,
          /// 和 SizeTransition的 配合控制动画播放效果
          alignment: Alignment.center,
          child: SizeTransition(
            sizeFactor: _controller,

            ///1. 如果axis=Axis.horizontal， 则不支持父控件alignment的垂直方向设置，默认在顶部
            ///2. 如果axis=Axis.vertical， 则不支持父控件alignment的水平方向设置，默认在左边
            axis: Axis.horizontal,

            /// 3.axisAlignment 取值范围：[1, -1], 当取值的绝对值大于等于1则不可见， 移动比例是以自身比例50%计算
            /// 4.axisAlignment=0.5 则向左边移动自身长度50%的50%，axisAlignment=-0.5 则向右边移动自身长度50%的50%，
            /// 如: 方向为水平，自身长度是100，axisAlignment=0.5， 则向左边移动25. 垂直方向同理.
            /// 如果要执行从中间开始向两边展开的动画，把View的初始位置设置在中心即.axisAlignment=0， 父窗体的alignment为center
            /// 如果要执行从左边进入的动画，把设置为和父控件相同大小，父控件的alignment为left,自己的axisAlignment设置为1
            axisAlignment: 0,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.green,
            ),
          ),
        ),));
  }
}
