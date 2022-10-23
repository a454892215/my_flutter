import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            SliverAppBar(
              // title: Container(color: Colors.red, child: const Text(''),),
              leading: const SizedBox(),

              /// SliverAppBar  pinned 表示SliverAppBar/flexibleSpace的title 是否跟着一起滑动到不可见（true 钉住，不滑动到不可见）
              pinned: true,

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
                tabs: const [
                  Tab(
                    child: Text("标题1"),
                  ),
                  Tab(
                    child: Text("标题2"),
                  ),
                  Tab(
                    child: Text("标题3"),
                  ),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            buildListView1(),
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              alignment: const Alignment(0, 0),
              child: const Text("页面2"),
            ),
            buildListView1(),
          ],
        ),
      ),
    );
  }

  ListView buildListView1() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.white,
          //  padding: const EdgeInsets.only(left: 12, right: 12),
          child: Container(
            height: 80,
            color: Colors.primaries[index % Colors.primaries.length],
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        );
      },
      itemCount: 20,
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
