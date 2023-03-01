import 'package:flutter/material.dart';

/// 1. NestedScrollView, SliverOverlapAbsorber, CustomScrollView, SliverOverlapInjector 示例
class NestedScrollViewSamplePage extends StatefulWidget {
  const NestedScrollViewSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  return const SnapAppBar();
    return Scaffold(
      appBar: AppBar(
        title: const Text("NestedScrollViewSamplePage2-示例"),
      ),
      /// 1. NestedScrollView 包裹内容， 设置 headerSliverBuilder 和 body
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            /// 2. SliverOverlapAbsorber 包裹 SliverAppBar
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: buildSliverAppBar(innerBoxIsScrolled),
            ),
          ];
        },
        /// 3. CustomScrollView， 包裹目标ListView 并且在目标ListView前面加上 SliverOverlapInjector
        body: Builder(builder: (BuildContext context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              buildSliverList(),
            ],
          );
        }),
      ),
    );
  }

  SliverAppBar buildSliverAppBar(bool innerBoxIsScrolled) {
    return SliverAppBar(
      forceElevated: innerBoxIsScrolled,
      title: Container(
        color: Colors.red,
        child: const Text('复仇者联盟'),
      ),
      leading: const SizedBox(),

      /// SliverAppBar  pinned 表示SliverAppBar/flexibleSpace的title 是否跟着一起滑动到不可见（true 钉住，不滑动到不可见）
      pinned: true,
      floating: true,
      expandedHeight: 180,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          color: Colors.green,
          child: const Text('复仇者联盟'),
        ),
        background: Container(
          color: Colors.yellow,
        ),
      ),
    );
  }
}

Widget buildSliverList([int count = 5]) {
  return SliverFixedExtentList(
    delegate: SliverChildBuilderDelegate(
      (ctx, index) {
        return ListTile(
          leading: Text("Item $index"),
        );
      },
      childCount: count,
    ),
    itemExtent: 50,
  );
}
