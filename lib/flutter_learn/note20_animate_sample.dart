import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../util/Log.dart';

class AnimationSamplePage extends StatefulWidget {
  const AnimationSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
  int listSize = 3;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {});
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
        body: ListView(
          children: [
            buildAnimatedAlign(),
          ],
        ));
  }

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
}

class _MyValuesNotifier extends ChangeNotifier {
  Alignment alignment = Alignment.topLeft;

  void playAlignAim() {
    alignment = alignment == Alignment.topLeft ? Alignment.topRight : Alignment.topLeft;
    notifyListeners();
  }
}
