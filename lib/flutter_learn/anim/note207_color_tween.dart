import 'package:flutter/material.dart';

main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: ColorTweenSample(),
    ),
  ));
}

///1. ColorTween
class ColorTweenSample extends StatefulWidget {
  const ColorTweenSample({Key? key}) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );

  /// 1. 创建颜色动画
  late final Animation _animation = ColorTween(begin: Colors.red, end: Colors.blue).animate(_controller);

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
      },
      child: Center(
        child: Container(
          width: 100,
          height: 100,

          /// 3. 应用动画
          color: _animation.value,
          alignment: Alignment.center,
          child: const Text("ColorTween", style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
