import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/ui_utils.dart';
/// 1. 只有下面的List可以滑动了，头部才能滑动隐藏
class CustomScrollViewSample2Page extends StatefulWidget {
  const CustomScrollViewSample2Page({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _MyValuesNotifier()),
      ],
      child: buildScaffold(tabController),
    );
  }

  Scaffold buildScaffold(TabController tabController) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          UIUtil.buildSliverAppBar(const Text("CustomScrollView2-示例"), buildFlexibleSpace(180)),
          const SliverPadding(padding: EdgeInsets.only(top: 10)),
          /// 只有下面的List可以滑动了，头部才能滑动隐藏
          UIUtil.buildSliverList((context, index) => UIUtil.buildContainer(index), 20),
        ],
      ),
    );
  }

  Container buildFlexibleSpace(double height) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.blue, Colors.red],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
