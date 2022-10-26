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
              buildAnimatedList(),
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
      return Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.only(top: 10),
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

  /// 6. AnimatedList
  Widget buildAnimatedList() {
    return Consumer<_MyValuesNotifier>(builder: (context, notifier, child) {
      return Container(
        alignment: Alignment.topLeft,
        color: Colors.green,
        margin: const EdgeInsets.only(top: 10),
        child: Consumer<_MyValuesNotifier>(builder: (context, notifier, child) {
          return Column(
            children: [
              Container(
                color: Colors.white,
                height: 120,
                child: AnimatedList(
                  key: notifier._listKey,
                  initialItemCount: 12,
                  itemBuilder: (BuildContext context, int index, Animation<double> animation) {
                    return GestureDetector(
                      onTap: () {
                        notifier.switchSelectedIndex(index);
                      },
                      child: buildListItem(animation, index, notifier),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                    onPressed: () {
                      if (notifier.selectedListIndex != null) {
                        notifier.insertItemFromList(notifier.selectedListIndex! + 1);
                        notifier.switchSelectedIndex(null);
                      }
                    },
                    child: const Text(
                      "add",
                      // 外层不要设置高度限制死，这里设置高度，撑出外层高度
                      style: TextStyle(height: 3),
                    ),
                  )),
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            if (notifier.selectedListIndex != null) {
                              notifier.remoteItemFromList(notifier.selectedListIndex!);
                              notifier.switchSelectedIndex(null);
                            }
                          },
                          child: const Text("del", style: TextStyle(height: 3)))),
                ],
              )
            ],
          );
        }),
      );
    });
  }
}

class _MyValuesNotifier extends ChangeNotifier {
  Alignment alignment = Alignment.topLeft;
  double positionLeft = 10;
  double positionStart = 10;
  double opacity = 1;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  int? selectedListIndex;

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

  void remoteItemFromList(int index) {
    _listKey.currentState?.removeItem(index, (context, animation) => buildListItem(animation, index, this));
    notifyListeners();
  }

  void insertItemFromList(int index) {
    _listKey.currentState?.insertItem(index);
    notifyListeners();
  }

  void switchSelectedIndex(int? index) {
    if (selectedListIndex == index || index == null) {
      selectedListIndex = null; // 取消选中
    } else {
      selectedListIndex = index; // 选中
    }
    notifyListeners();
  }
}

SizeTransition buildListItem(Animation<double> animation, int index, notifier) {
  bool selected = index == notifier.selectedListIndex;
  return SizeTransition(
    sizeFactor: animation,
    child: Container(
      height: 30,
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(top: 5),
      color: Colors.primaries[(index) % Colors.primaries.length],
      child: selected ? const Icon(Icons.check_circle_sharp) : null,
    ),
  );
}
