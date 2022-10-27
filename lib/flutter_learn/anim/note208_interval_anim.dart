import 'package:flutter/material.dart';

import '../../util/toast_util.dart';

main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: IntervalAnimSample(),
    ),
  ));
}

///1. CurvedAnimation-Interval 插值延时动画，即可以指定原动画运行到指定位置才开始动画
class IntervalAnimSample extends StatefulWidget {
  const IntervalAnimSample({Key? key}) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 2000),
    vsync: this,
  );

  /// 1. 创建颜色动画
  late final Animation<double> _rotationAnim2 = Tween(begin: 0.0, end: 5.0).animate(_controller);
  late final Animation<Offset> _slideAnim2 =
      Tween(begin: const Offset(0, 0), end: const Offset(8, 0)).animate(_controller);

  late final Animation<double> _rotationAnim1 = Tween(begin: 0.0, end: 5.0).animate(CurvedAnimation(
    parent: _controller,
    //1. 0.5 表示值到动画播放到一半才开始
    curve: const Interval(0.2, 1.0),
  ));
  late final Animation<Offset> _slideAnim1 =
      Tween(begin: const Offset(0, 0), end: const Offset(8, 0)).animate(CurvedAnimation(
    parent: _controller,

    ///1. 0.5 表示值到动画播放到一半才开始
    curve: const Interval(0.2, 1.0),
  ));

  @override
  void initState() {
    _controller.addListener(() {
      /// 2. 监听并且 实时刷新
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.status == AnimationStatus.completed) {
          _controller.reverse(from: 1);
        } else if (_controller.status == AnimationStatus.dismissed) {
          _controller.forward(from: 0);
        }
        Toast.show("Interval");
      },
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.all(10),
        color: Colors.green,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCircle1(),
            const Padding(padding: EdgeInsets.all(3)),
            buildCircle2(),
          ],
        ),
      ),
    );
  }

  SlideTransition buildCircle1() {
    return SlideTransition(
      position: _slideAnim1,
      child: RotationTransition(
        turns: _rotationAnim1,
        child: Container(
          height: 26,
          width: 26,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(13),
          ),
          alignment: Alignment.center,
          child: const Text("1", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  SlideTransition buildCircle2() {
    return SlideTransition(
      position: _slideAnim2,
      child: RotationTransition(
        turns: _rotationAnim2,
        child: Container(
          height: 26,
          width: 26,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(13),
          ),
          alignment: Alignment.center,
          child: const Text("2", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
