import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/ui_utils.dart';
/// 1. CustomScrollView 示例用法
/// 2. SliverPadding 示例用法
/// 3. SliverGrid 示例用法
/// 4. SliverFixedExtentList
class CustomScrollViewSamplePage extends StatefulWidget {
  const CustomScrollViewSamplePage({super.key});

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
        title: const Text("CustomScrollViewSamplePage-示例"),
      ),
      body: CustomScrollView(
        slivers: [
          // const SliverAppBar(title: Text("CustomScroll-示例")), 进度条会越界到 SliverAppBar
          /// 不能使用普通 Padding
          const SliverPadding(padding: EdgeInsets.only(top: 10)),
          UIUtil.buildSliverGrid((context, index) => UIUtil.buildContainer(index), 20, 3),
          const SliverPadding(padding: EdgeInsets.only(top: 10)),
          UIUtil.buildSliverFixedExtentList((context, index) => UIUtil.buildContainer(index), 20),
          // SliverFixedExtentList(delegate: delegat2e, itemExtent: 20);
        ],
      ),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
