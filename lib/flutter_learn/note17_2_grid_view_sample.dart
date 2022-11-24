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
        title: const Text("GridView-示例"),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
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
            Container(
              height: 200,
              margin: const EdgeInsets.only(top: 12),
              color: Colors.grey[500],
              child: buildGridView4(),
            ),
          ],
        ),
      ),
    );
  }

  /// 4. 按需加载： GridView.custom
  GridView buildGridView4() {
    return GridView.custom(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),//增加
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

  /// 3. 按需加载，当需要显示就返回指定index的Item Widget： GridView.builder
  GridView buildGridView3() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),//增加
        itemCount: 100,
       // physics: const BouncingScrollPhysics(),
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

  /// 2. 适用于条目比较少的情况， 一次性全部加载： GridView.count
  /// 2. 适用于条目比较少的情况, 创建不固定列表数， 一次性全部加载： GridView.extent
  GridView buildGridView2() {
    return GridView.extent(
      // 纵坐标最大item 宽度
      maxCrossAxisExtent: 150,
      childAspectRatio: 0.8,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      shrinkWrap: true,
      //physics: const NeverScrollableScrollPhysics(),//增加
       physics: const BouncingScrollPhysics(),
      children: ListU.fillRange(0, 6)
          .map((e) => Container(
                color: Colors.yellow,
                alignment: Alignment.center,
                child: Text("文本$e"),
              ))
          .toList(),
    );
  }

  /// 1.  适用于条目比较少的情况, 一次性全部加载: GridView()
  GridView buildGridView1() {
    return GridView(
      // 内容不足的时候是否能够滑动？(不一定生效)
      primary: false,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),//增加

      /// 当内容没有超过父容器 并且 primary: false, Android测试也有滑动效果
      // physics: const AlwaysScrollableScrollPhysics(),
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
