import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/Log.dart';

/// RefreshIndicator 下拉刷新，和加载更多
class RefreshSamplePage extends StatefulWidget {
  const RefreshSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
  int listSize = 9;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // num scrolledOffset = _scrollController.offset;
      ///2.  滑到底部， 加载更多
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          listSize += 2;
        });
      }
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
      appBar: AppBar(
        title: const Text("RefreshIndicator-示例"),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            /// RefreshIndicator 数据量不足一屏幕无法下拉刷新.
            RefreshIndicator(

                /// 刷新悬停位置到顶部距离
                displacement: 20,
                onRefresh: onRefresh,
                child: listViewContent()),
          ],
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    Log.d("=======onRefresh=========");
    await Future.delayed(const Duration(milliseconds: 1000), () {
      // 延时结束后执行的函数
      setState(() {
        listSize += 2;
      });
    });
  }

  Container listViewContent() {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(top: 12),
      color: Colors.grey[500],
      child: buildListView3(),
    );
  }

  /// 3. 带有分割线的 按需加载： ListView.separated
  ListView buildListView3() {
    return ListView.separated(
        itemCount: listSize + 1,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
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
          String text = index == listSize ? "加载更多" : "文本$index";
          return Container(
            height: 30,
            margin: const EdgeInsets.only(left: 10, right: 10),
            color: Colors.green,
            alignment: Alignment.center,
            child: Text(text),
          );
        });
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
