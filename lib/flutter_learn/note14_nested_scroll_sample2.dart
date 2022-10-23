import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String summary = '''
1. NestedScrollView用法示例
2. SliverAppBar 用法示例
3. FlexibleSpaceBar 用法示例
4. TabBar 用法示例
5. TabBarView 用法示例
6. liverFixedExtentList
''';

class NestedScrollViewSamplePage2 extends StatefulWidget {
  const NestedScrollViewSamplePage2({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
  late TabController tabController;
  final List<String> titles = ['标题1', '标题2', '标题3'];

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
        title: const Text("NestedScrollView2-示例"),
        backgroundColor: Colors.pink,
      ),
      body: NestedScrollView(
        // physics: const BouncingScrollPhysics(), 无效
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: buildSliverAppBar(innerBoxIsScrolled, tabController),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            getPage(buildSliverList(1, getFirstPageView())),
            getPage(buildSliverList()),
            getPage(buildSliverList()),
          ],
        ),
      ),
    );
  }

  Widget getFirstPageView() {
    return Container(
            alignment: Alignment.topCenter,
            color: Colors.blue,
            child: Text(
              summary,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
  }

  Widget getPage(Widget page) {
    return Builder(builder: (context) {
      return CustomScrollView(
        slivers: [
          SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          page,
        ],
      );
    });
  }

  SliverAppBar buildSliverAppBar(bool innerBoxIsScrolled, TabController tabController) {
    return SliverAppBar(
      // title: Container(color: Colors.red, child: const Text(''),),
      leading: const SizedBox(),

      /// SliverAppBar  pinned 表示SliverAppBar/flexibleSpace的title 是否跟着一起滑动到不可见（true 钉住，不滑动到不可见）
      pinned: true,
      forceElevated: innerBoxIsScrolled,

      /// floating true 表示可以完全隐藏flexibleSpace的background的高度...
      floating: true,
      expandedHeight: 180,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        // title: Container( child: const Text('复仇者联盟'),),
        background: Align(
          alignment: Alignment.topCenter,
          child: Container(
            /// 标题栏的高度是： expandedHeight - height
            height: 130,
            color: Colors.blue,
            alignment: const Alignment(0, 0),
            child: const Text(
              "我是顶部头",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      bottom: TabBar(
        labelColor: Colors.white,
        controller: tabController,
        tabs: titles
            .map((e) => Tab(
                  child: Text(e),
                ))
            .toList(), //
      ),
    );
  }

  Widget buildSliverList([int count = 5, Widget? child]) {
    double height = child == null ? 50 : 300;
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return child ?? Container(
            color: Colors.primaries[index % Colors.primaries.length],
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          );
        },
        childCount: count,
      ),
      /// item高度
      itemExtent: height,
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
