import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/ui_utils.dart';

class CustomScrollViewSamplePage extends StatefulWidget {
  const CustomScrollViewSamplePage({super.key});

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
      appBar: AppBar(
        title: const Text("CustomScroll-示例"),
      ),
      body: CustomScrollView(
        slivers: [
          // const SliverAppBar(title: Text("CustomScroll-示例")), 进度条会越界到 SliverAppBar
          /// 不能使用普通 Padding
          const SliverPadding(padding: EdgeInsets.only(top: 10)),
          UIUtil.buildSliverGrid(20, null, 3),
          // SliverFixedExtentList(delegate: delegat2e, itemExtent: 20);
        ],
      ),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
