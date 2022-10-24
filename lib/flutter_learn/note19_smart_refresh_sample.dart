import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  int listSize = 3;
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
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
        title: const Text("SmartRefresher-示例"),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              height: 300,
              color: Colors.grey[500],
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
        header: const WaterDropHeader(),
        footer: buildCustomFooter(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: buildListView());
  }

  CustomFooter buildCustomFooter() {
    return CustomFooter(
      builder: (context, mode) {
        Widget footerView;
        if (mode == LoadStatus.idle) {
          footerView = const Text("上拉加载");
        } else if (mode == LoadStatus.loading) {
          footerView = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          footerView = const Text("加载失败, 点击重试！");
        } else if (mode == LoadStatus.canLoading) {
          footerView = const Text("松手,加载更多!");
        } else {
          footerView = const Text("没有更多数据了!");
        }
        return SizedBox(height: 55.0, child: Center(child: footerView));
      },
    );
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      listSize  = 5;
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      listSize += 2;
      _refreshController.loadComplete();
    });
  }

  /// 3. 带有分割线的 按需加载： ListView.separated
  ListView buildListView() {
    return ListView.separated(
        itemCount: listSize,
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
          String text = "文本$index";
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
