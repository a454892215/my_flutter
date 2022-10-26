import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String summary = ''' 
1. AnimatedAlign
2. AnimatedPositioned
3. AnimatedPositionedDirectional
4. AnimatedOpacity
5. AnimatedDefaultTextStyle
''';

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
          child: ListView(
            children: [
              buildAnimatedAlign(),
              buildAnimatedPositioned(),
              buildAnimatedPositionedDirectional(),
              buildAnimatedOpacity(),
              buildAnimatedDefaultTextStyle(),
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
          onPressed: () => notifier.playAnimatedAlign(),
          color: Colors.blue,
          child: const Text("AnimatedAlign"),
        ),
      );
    });
  }

  /// 2. AnimatedPositioned
  Widget buildAnimatedPositioned() {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      color: Colors.purple,
      child: Stack(
        children: [
          Consumer<_MyValuesNotifier>(builder: (context, notifier, child) {
            return AnimatedPositioned(
              left: notifier.positionLeft,
              top: 10,
              width: 160,
              height: 50,
              duration: const Duration(milliseconds: 250),
              child: Container(
                color: Colors.blue,
                child: MaterialButton(
                  onPressed: () => notifier.playAnimatedPositioned(),
                  color: Colors.blue,
                  child: const Text("AnimatedPositioned"),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 3. AnimatedPositionedDirectional
  Widget buildAnimatedPositionedDirectional() {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      color: Colors.purple,
      child: Stack(
        children: [
          Consumer<_MyValuesNotifier>(builder: (context, notifier, child) {
            return AnimatedPositionedDirectional(
              start: notifier.positionStart,
              top: 10,
              width: 160,
              height: 50,
              duration: const Duration(milliseconds: 250),
              child: Container(
                color: Colors.blue,
                child: MaterialButton(
                  onPressed: () => notifier.playAnimatedPositionedStart(),
                  color: Colors.blue,
                  child: const Text("AnimatedPositionedDirectional"),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 4. AnimatedOpacity
  Widget buildAnimatedOpacity() {
    return Consumer<_MyValuesNotifier>(builder: (context, notifier, child) {
      return Align(
        alignment: Alignment.topLeft,
        child: AnimatedOpacity(
          opacity: notifier.opacity,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 250),
          child: MaterialButton(
            onPressed: () => notifier.playAnimatedOpacity(),
            color: Colors.blue,
            child: const Text("AnimatedOpacity"),
          ),
        ),
      );
    });
  }

  /// 5. AnimatedDefaultTextStyle
  Widget buildAnimatedDefaultTextStyle() {
    return Consumer<_MyValuesNotifier>(builder: (context, notifier, child) {
      return Container(
        height: 80,
        color: Colors.orange,
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              style: notifier.textStyle,
              curve: Curves.linear,
              duration: const Duration(milliseconds: 250),
              child: const Text("AnimatedDefaultTextStyle"),
            ),
            const Padding(padding: EdgeInsets.only(top: 12)),
            MaterialButton(
              onPressed: () => notifier.playAnimatedDefaultTextStyle(),
              color: Colors.blue,
              child: const Text("start play"),
            )
          ],
        ),
      );
    });
  }
}

class _MyValuesNotifier extends ChangeNotifier {
  Alignment alignment = Alignment.topLeft;
  double positionLeft = 10;
  double positionStart = 10;
  double opacity = 1;
  static TextStyle defTextStyle = const TextStyle(color: Colors.white, fontSize: 12);
  static TextStyle defTextStyle2 = const TextStyle(color: Colors.blue, fontSize: 13);
  TextStyle textStyle = defTextStyle;

  void playAnimatedAlign() {
    alignment = alignment == Alignment.topLeft ? Alignment.topRight : Alignment.topLeft;
    notifyListeners();
  }

  void playAnimatedPositioned() {
    positionLeft = positionLeft == 10 ? 260 : 10;
    notifyListeners();
  }

  void playAnimatedPositionedStart() {
    positionStart = positionStart == 10 ? 260 : 10;
    notifyListeners();
  }

  void playAnimatedOpacity() {
    opacity = opacity == 1 ? 0.1 : 1;
    notifyListeners();
  }

  void playAnimatedDefaultTextStyle() {
    textStyle = textStyle == defTextStyle ? defTextStyle2 : defTextStyle;
    notifyListeners();
  }
}
