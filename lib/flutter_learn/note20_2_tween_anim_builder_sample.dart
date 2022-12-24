import 'package:flutter/material.dart';

import '../style/dimen.dart';
import '../util/Log.dart';

class TweenAnimationBuilderTestPage extends StatefulWidget {
  const TweenAnimationBuilderTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  ValueNotifier<int> notifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TweenAnimationBuilder-示例"),
        ),
        body: ListView(
          children: [
            buildAnim1(),
          ],
        ));
  }

  ColorTween colorTween = ColorTween(begin: const Color(0xff2865d7), end: const Color(0xfffca2ed));

  GestureDetector buildAnim1() {
    return GestureDetector(
      onTap: () {
        notifier.value++;
        Log.d("notifier.value: ${notifier.value}");
      },
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, value, child) {
          return TweenAnimationBuilder(
            key: GlobalKey(),
            /// 需要每次不同key 刷新动画才能生效
            builder: (BuildContext context, double value, Widget? child) {
              return buildAnimChild(value);
            },
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 3000),
            child: buildAnimChild(0),
          );
        },
      ),
    );
  }

  Widget buildAnimChild(double value) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        color: colorTween.lerp(value),
        width: dimen1 * 1080 * value,
        height: 30,
      ),
    );
  }
}
