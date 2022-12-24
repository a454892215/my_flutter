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

class _State extends State with TickerProviderStateMixin {
  ValueNotifier<int> notifier = ValueNotifier<int>(0);
  late final AnimationController controller1 = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
    reverseDuration: const Duration(milliseconds: 1000),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TweenAnimationBuilder等-示例"),
        ),
        body: ListView(
          children: [
            buildAnim1(),
            _buildPositionedTransition(),
          ],
        ));
  }

  Widget _buildPositionedTransition() {
    return GestureDetector(
      onTap: () {
        if(controller1.isCompleted){
          Log.d("======isCompleted=======");
          controller1.reverse();
        }else if(controller1.isDismissed){
          Log.d("======isDismissed=======");
          controller1.forward();
        }

      },
      child: Container(
        height: 150,
        color: Colors.grey,
        child: Stack(
          children: [
            PositionedTransition(
                rect: RelativeRectTween(
                  begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
                  end: const RelativeRect.fromLTRB(70, 0, 0, 0),
                ).animate(CurvedAnimation(
                  parent: controller1,
                  curve: Curves.linear,
                )),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 160,
                    height: 60,
                    color: Colors.purple,
                    alignment: Alignment.center,
                    child: const Text("PositionedTransition示例"),
                  ),
                ))
          ],
        ),
      ),
    );
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
