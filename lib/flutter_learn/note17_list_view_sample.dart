import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/Log.dart';
import '../util/list_util.dart';

/// ListView 加载的三种方式和滚动监听等
class ListViewSamplePage extends StatefulWidget {
  const ListViewSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 监听滑动
    _scrollController.addListener(() {
      num scrolledOffset = _scrollController.offset;
      Log.d("scrolledOffset $scrolledOffset");
    });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // 滚动到ListView 顶部
            _scrollController.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeInSine);
          });
        },
        child: const Icon(Icons.arrow_upward),
      ),
      appBar: AppBar(
        title: const Text("ListView-示例"),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              height: 200,
              margin: const EdgeInsets.only(top: 12),
              color: Colors.grey[500],
              child: buildListView1(),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.only(top: 12),
              color: Colors.grey[500],
              child: buildListView2(),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.only(top: 12),
              color: Colors.grey[500],
              child: buildListView3(),
            ),
          ],
        ),
      ),
    );
  }

  /// 3. 带有分割线的 按需加载： ListView.separated
  ListView buildListView3() {
    return ListView.separated(
        itemCount: 100,
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.red,
            height: 5,
            margin: const EdgeInsets.only(left: 10, right: 10),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          // Log.d("itemBuilder index: $index");
          return Container(
            height: 30,
            margin: const EdgeInsets.only(left: 10, right: 10),
            color: Colors.green,
            alignment: Alignment.center,
            child: Text("文本$index"),
          );
        });
  }

  /// 2. 按需加载，当需要显示就返回指定index的Item Widget： ListView.builder
  ListView buildListView2() {
    return ListView.builder(
        itemCount: 100,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          // Log.d("itemBuilder index: $index");
          return Container(
            height: 30,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            color: Colors.green,
            alignment: Alignment.center,
            child: Text("文本$index"),
          );
        });
  }

  /// 1. 直接加载所有ListView Item
  ListView buildListView1() {
    return ListView(
      // size 不包裹内容
      shrinkWrap: false,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      children: ListU.fillRange(0, 200)
          .map((e) => Container(
                height: 30,
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                color: Colors.green,
                alignment: Alignment.center,
                child: Text("文本$e"),
              ))
          .toList(),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
