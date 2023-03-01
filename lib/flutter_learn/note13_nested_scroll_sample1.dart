import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
        title: const Text("嵌套滚动-示例列表"),
      ),

      /// 1. NestedScrollView 包裹内容， 设置 headerSliverBuilder 和 body
      body: ListView(
        children: [
          CupertinoButton(child: const Text("问题示例1"), onPressed: () => Get.to(() => const Sample1())),
          CupertinoButton(child: const Text("问题示例2"), onPressed: () => Get.to(() => const Sample2())),
          CupertinoButton(child: const Text("正常示例3"), onPressed: () => Get.to(() => const Sample3())),
        ],
      ),
    );
  }

  Widget buildSliverAppBar(bool innerBoxIsScrolled) {
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

class Sample1 extends StatelessWidget {
  const Sample1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                forceElevated: innerBoxIsScrolled,

                /// SliverAppBar  pinned 表示SliverAppBar/flexibleSpace的title 是否跟着一起滑动到不可见（true 钉住，不滑动到不可见）
                title: const SizedBox(),
                leading: const SizedBox(),
                pinned: true,
                floating: true,
                expandedHeight: 180,
                collapsedHeight: 0,
                //  collapsedHeight >= toolbarHeight
                toolbarHeight: 0,
                flexibleSpace: Container(
                  color: Colors.yellow,
                  child: OverflowBox(
                    maxHeight: 180,
                    child: Column(
                      children: const [
                        SizedBox(height: 30),
                        Text("data ============== 1"),
                        Text("data ============== 2"),
                        Text("data ============== 3"),
                        Text("data ============== 4"),
                        Text("data    ===========   5"),
                        Text("data =================== 6"),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ];
        },
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
}

class Sample2 extends StatelessWidget {
  const Sample2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                forceElevated: innerBoxIsScrolled,

                /// SliverAppBar  pinned 表示SliverAppBar/flexibleSpace的title 是否跟着一起滑动到不可见（true 钉住，不滑动到不可见）
                title: const SizedBox(),
                leading: const SizedBox(),
                pinned: true,
                floating: true,
                expandedHeight: 180,
                collapsedHeight: 0,
                //  collapsedHeight >= toolbarHeight
                toolbarHeight: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.yellow,
                    child: Column(
                      children: const [
                        SizedBox(height: 30),
                        Text("data ============== 1"),
                        Text("data ============== 2"),
                        Text("data ============== 3"),
                        Text("data ============== 4"),
                        Text("data    ===========   5"),
                        Text("data =================== 6"),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ];
        },
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
}

class Sample3 extends StatelessWidget {
  const Sample3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Container(color: Colors.blue),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                backgroundColor: Colors.white, // 收起的过渡颜色
                /// SliverAppBar  pinned 表示SliverAppBar/flexibleSpace的title 是否跟着一起滑动到不可见（true 钉住，不滑动到不可见）
                title: const SizedBox(),
                leading: const SizedBox(),
                pinned: true,
                floating: true,
                expandedHeight: 180,
                collapsedHeight: 0,
                //  collapsedHeight >= toolbarHeight
                toolbarHeight: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.yellow,
                    child: Column(
                      children: const [
                        Text("data ============== 1"),
                        Text("data ============== 2"),
                        Text("data ============== 3"),
                        Text("data ============== 4"),
                        Text("data    ===========   5"),
                        Text("data =================== 6"),
                        Text("data =================== 7"),
                        Text("data =================== 8"),
                        Text("data =================== 9"),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ];
        },
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
    itemExtent: 50, //height
  );
}
