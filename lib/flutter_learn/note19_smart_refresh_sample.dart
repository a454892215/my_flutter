import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../util/Log.dart';

/// SmartRefresher 下拉刷新，和加载更多
/// 一定要注意的是,ListView一定要作为SmartRefresher的child,不能与其分开,详细原因看
class SmartRefreshSamplePage extends StatefulWidget {
  const SmartRefreshSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
  List<String> list = [];
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      list.add("data:-$i");
    }
    _scrollController.addListener(() {});
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
        title: const Text("SmartRefresher-聊天室-示例"),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              height: 300,
              color: const Color(0xffa8a8a8),
              child: buildSmartRefresher(),
            ),
          ],
        ),
      ),
    );
  }

  SmartRefresher buildSmartRefresher() {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
        footer: const ClassicFooter(loadingIcon: CupertinoActivityIndicator()),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoadMore,
        child: buildListView());
  }

  void _onLoadMore() async {
    Log.d("==============_onLoadMore=================");
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      for (int i = 0; i < 10; i++) {
        list.add("data:-$i");
      }
      _refreshController.loadComplete();
    });
  }

  void _onRefresh() async {
    Log.d("==============_onRefresh=================");
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      list.clear();
      for (int i = 0; i < 3; i++) {
        list.add("data:-$i");
      }
      _refreshController.refreshCompleted();
    });
  }

  /// 3. 带有分割线的 按需加载： ListView.separated
  ListView buildListView() {
    return ListView.separated(
        itemCount: list.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
        reverse: true,
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
          String text = "文本$index";
          return Container(
            height: 60,
            margin: const EdgeInsets.only(left: 10, right: 10),
            color: Colors.green,
            alignment: Alignment.center,
            child: Text(text),
          );
        });
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
