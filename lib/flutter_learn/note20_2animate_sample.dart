import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// AnimatedContainer 示例
class AnimationSample2Page extends StatefulWidget {
  const AnimationSample2Page({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _MyValuesNotifier()),
      ],
      child: buildScaffold(),
    );
  }

  Widget buildScaffold() {
    return Container(
      color: Colors.grey,
      child: Consumer<_MyValuesNotifier>(builder: (context, notifier, child) {
        return Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: notifier.curBox.width,
              height: notifier.curBox.height,
              padding: notifier.curBox.padding,
              alignment: notifier.curBox.alignment,
              decoration: notifier.curBox.decoration,
            ),
            Row(
              children: [
                Expanded(
                    child: MaterialButton(
                        onPressed: () {
                          notifier.playAnim();
                        },
                        color: Colors.blue,
                        child: const Text("start Anim", style: TextStyle(height: 3)))),
              ],
            )
          ],
        );
      }),
    );
  }
}

class _MyBox {
  double? width = 20;
  double? height = 20;
  EdgeInsets? padding = const EdgeInsets.only(left: 0);
  Color? color = Colors.black;
  Alignment? alignment = Alignment.topLeft;
  BoxDecoration? decoration;

  _MyBox({this.width, this.height, this.padding, this.color, this.alignment, this.decoration});
}

class _MyValuesNotifier extends ChangeNotifier {
  static _MyBox box_1 = _MyBox(
    width: 100,
    height: 90,
    padding: const EdgeInsets.only(left: 0),
    color: Colors.orange,
    alignment: Alignment.topLeft,
    decoration: BoxDecoration(
        color: Colors.orange,
        border: Border.all(width: 0, color: Colors.transparent),
        borderRadius: const BorderRadius.all(Radius.circular(0))),
  );

  static _MyBox box_2 = _MyBox(
    width: 200,
    height: 100,
    padding: const EdgeInsets.only(left: 10),
    color: Colors.blue,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 4, color: Colors.red),
        borderRadius: const BorderRadius.all(Radius.circular(20))),
  );

  _MyBox curBox = box_1;

  void playAnim() {
    curBox = curBox == box_1 ? box_2 : box_1;
    notifyListeners();
  }
}
