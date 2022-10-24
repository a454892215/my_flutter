

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/list_util.dart';

/// ListView 加载的三种方式和滚动监听等
class GridViewSamplePage extends StatefulWidget {
  const GridViewSamplePage({super.key});

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
      //   num scrolledOffset = _scrollController.offset;
      //  Log.d("scrolledOffset $scrolledOffset");
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
        title: const Text("GridView-示例"),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              height: 200,
              margin: const EdgeInsets.only(top: 12),
              color: Colors.grey[500],
              child: buildGridView1(),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.only(top: 12),
              color: Colors.grey[500],
              child: buildGridView2(),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.only(top: 12),
              color: Colors.grey[500],
              child: buildGridView3(),
            ),
          ],
        ),
      ),
    );
  }

  /// 3. 按需加载： GridView.custom
  GridView buildGridView3() {
    return GridView.custom(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      childrenDelegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(color: Colors.green);
      }),
    );
  }

  /// 2. 按需加载，当需要显示就返回指定index的Item Widget： GridView.builder
  GridView buildGridView2() {
    return GridView.builder(
        itemCount: 100,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1.0,
        ),
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

  /// 1. 直接加载所有 GridView Item
  GridView buildGridView1() {
    return GridView(
      // 内容不足的时候是否能够滑动？(不一定生效)
      primary: false,
      shrinkWrap: false,
      scrollDirection: Axis.vertical,
      /// 当内容没有超过父容器 并且 primary: false, Android测试也有滑动效果
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      children: ListU.fillRange(0, 6)
          .map((e) => Container(
                height: 30,
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                color: Colors.pink,
                alignment: Alignment.center,
                child: Text("文本$e"),
              ))
          .toList(),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
