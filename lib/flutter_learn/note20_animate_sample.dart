import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimationSamplePage extends StatefulWidget {
  const AnimationSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _MyValuesNotifier()),
      ],
      child: buildScaffold(),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Animation-示例"),
        ),
        body: Container(
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAnimatedAlign(),
              buildAnimatedPositioned(),
            ],
          ),
        ));
  }

  /// 1. AnimatedAlign
  Widget buildAnimatedAlign() {
    return Consumer<_MyValuesNotifier>(builder: (context, notifier, child) {
      return AnimatedAlign(
        alignment: notifier.alignment,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 250),
        child: MaterialButton(
          onPressed: () => notifier.playAlignAim(),
          color: Colors.blue,
          child: const Text("点击play-AnimatedAlign动画"),
        ),
      );
    });
  }

  /// 2. buildAnimatedPositioned
  Widget buildAnimatedPositioned() {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      color: Colors.purple,
      child: Stack(
        children: [
          /// 1. 注意如果Positioned视图越界会抛异常，异常log难定位??
          Consumer<_MyValuesNotifier>(builder: (context, notifier, child) {
            return AnimatedPositioned(
              left: notifier.positionLeft,
              top: 10,
              width: 100,
              height: 100,
              duration: const Duration(milliseconds: 250),
              child: Container(
                color: Colors.blue,
                child: MaterialButton(
                  onPressed: () => notifier.playAnimatedPositionedAnim(),
                  color: Colors.blue,
                  child: const Text("play-AnimatedPositioned-动画"),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {
  Alignment alignment = Alignment.topLeft;
  double positionLeft = 10;

  void playAlignAim() {
    alignment = alignment == Alignment.topLeft ? Alignment.topRight : Alignment.topLeft;
    notifyListeners();
  }

  void playAnimatedPositionedAnim() {
    positionLeft = positionLeft == 10 ? 220 : 10;
    notifyListeners();
  }
}
