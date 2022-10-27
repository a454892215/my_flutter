import 'package:flutter/material.dart';

main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: TweenAnimationBuilderSample(),
    ),
  ));
}

///1. ColorTween
class TweenAnimationBuilderSample extends StatefulWidget {
  const TweenAnimationBuilderSample({Key? key}) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      /// 能设置动画播放时机吗
      child: TweenAnimationBuilder(
        builder: (BuildContext context, double value, Widget? child) {
          return Opacity(
            opacity: value,
            child: Padding(
              padding: EdgeInsets.only(top: value * 10, left: value * 10),
              ///1. child必须要有
              child: child,
            ),
          );
        },
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 3000),
        child: Container(
          color: Colors.blue,
          width: 160,
          height: 30,
        ),
      ),
    );
  }
}
