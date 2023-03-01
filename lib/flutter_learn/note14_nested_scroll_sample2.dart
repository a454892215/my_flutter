import 'package:flutter/material.dart';

import '../my_widgets/nested_scroll_widget.dart';

/// 1. 只有下面的List可以滑动了，头部才能滑动隐藏
class NestedScrollViewSamplePage2 extends StatefulWidget {
  const NestedScrollViewSamplePage2({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: AppBar(title: const Text("标题栏")),
      body: NestedScrollWidget(
        topTitle: Container(
          width: double.infinity,
          height: 30,
          color: Colors.green,
          child: const Text("主标题栏", style: TextStyle(fontSize: 12, color: Colors.white)),
        ),
        bottomTitle: Container(
          width: double.infinity,
          height: 30,
          color: Colors.pink,
          child: const Text(
            "子标题栏",
            style: TextStyle(fontSize: 12),
          ),
        ),
        background: Container(
          color: Colors.yellow,
          child: Column(
            children: const [
              SizedBox(height: 35),
              Text("data ============== 1"),
              Text("data ============== 2"),
              Text("data ============== 3"),
              Text("data ============== 4"),
              Text("data ============== 5"),
              Text("data ============== 6"),
            ],
          ),
        ),
        listWidget: SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, listIndex) => Container(
                    height: 50,
                    color: Colors.primaries[(listIndex) % Colors.primaries.length],
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '$listIndex',
                      style: const TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
              childCount: 20),
        ),
      ),
    );
  }
}
