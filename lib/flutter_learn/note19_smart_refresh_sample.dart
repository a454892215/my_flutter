import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresher.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../my_widgets/refresher/my_physics.dart';
import '../my_widgets/refresher/refresh_state.dart';
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

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 20; i++) {
      list.add("data:-$i");
    }
    addDataForList2(40);
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

  ScrollController sc = ScrollController();
  double refresherContentHeight = 300;
  double refresherContentWidth = 1080.w;

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
              height: 250,
              padding: const EdgeInsets.all(10),
              color: const Color(0xffa8a8a8),
              child: buildSmartRefresher(),
            ),
            Expanded(child: LayoutBuilder(
              builder: (context, constraint) {
                Log.d("constraint : ${constraint.maxHeight}");
                refresherContentHeight = constraint.maxHeight;
                return Refresher(
                    sc: sc,
                    height: refresherContentHeight,
                    width: refresherContentWidth,
                    isReverseScroll: true,
                    controller: RefresherController(),
                    headerFnc: RefresherFunc.load_more,
                    onHeaderLoad: (state) async {
                      await Future.delayed(const Duration(milliseconds: 1000));
                      addDataForList2(20);
                      listView2Notifier.value++;
                      state.notifyRefreshFinish();
                    },
                    onFooterLoad: (state) {},
                    child: Container(
                      height: refresherContentHeight,
                      width: refresherContentWidth,
                      color: const Color(0xffaeeeae),
                      //   padding: const EdgeInsets.all(10),
                      child: buildListView2(sc),
                    ));
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget buildSmartRefresher() {
    return RefreshConfiguration.copyAncestor(
        enableBallisticLoad: false,
        // 禁止惯性滑动加载更多
        context: context,
        enableRefreshVibrate: true,
        footerTriggerDistance: -1,
        child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const ClassicHeader(
              refreshingIcon: CupertinoActivityIndicator(),
              height: 60,
            ),
            footer: const ClassicFooter(
              loadingIcon: CupertinoActivityIndicator(),
              height: 90,
              loadStyle: LoadStyle.ShowWhenLoading,
            ),
            // reverse: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoadMore,
            child: buildListView()));
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
        key: UniqueKey(),
        itemCount: list.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
        reverse: true,
        controller: ScrollController(),
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

  var list2 = [];
  late final ValueNotifier<int> listView2Notifier = ValueNotifier<int>(0);

  /// 3. 带有分割线的 按需加载： ListView.separated
  Widget buildListView2(ScrollController sc) {
    return ValueListenableBuilder(
        valueListenable: listView2Notifier,
        builder: (a, b, c) {
          return ListView.separated(
              itemCount: list2.length,
              physics: RefresherClampingScrollPhysics(),
              shrinkWrap: false,
              reverse: true,
              controller: sc,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.red,
                  height: 5,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                // Log.d("itemBuilder index: $index");
                String text = "文本$index";
                return GestureDetector(
                  child: Container(
                    height: getItemHeight(index),
                    color: Colors.green,
                    alignment: Alignment.center,
                    child: Text(text),
                  ),
                  onTap: (){
                    toast('index: $index');
                   // sc.jumpTo()
                  },
                );
              });
        });
  }

  //
  double getItemHeight(int index) {
    int mod = index % 3 + 1;
    return 40 + mod * 15;
  }

  void addDataForList2(int size) {
    for (int i = 0; i < size; i++) {
      list2.add("data");
    }
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
