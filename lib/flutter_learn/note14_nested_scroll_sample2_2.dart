import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import '../util/Log.dart';

/// 1. 只有下面的List可以滑动了，头部才能滑动隐藏
class EasyRefreshSamplePage extends StatefulWidget {
  const EasyRefreshSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  EasyRefreshController refreshController = EasyRefreshController();

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: AppBar(title: const Text("EasyRefresh 示例")),
      body: Center(
        child: Obx(() {
          Log.d("========Obx====listSize:$listSize==refreshCount:${requestDataCount.value}");
          return EasyRefresh.custom(
            ///1.  注意  slivers中 无法触发 Obx 和 ValueListenableBuilder的刷新机制 ？？？
            slivers: <Widget>[
              SliverToBoxAdapter(
                  child: Container(
                width: double.infinity,
                height: 180,
                color: Colors.blue,
                    alignment: Alignment.bottomLeft,
                    child: const Text("标题栏"),
              )),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, listIndex) => Container(
                          height: 50,
                          color: Colors.primaries[(listIndex) % Colors.primaries.length],
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '$listIndex',
                            style: const TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ),
                    childCount: listSize + 1),
              ),
            ],

            controller: refreshController,
            onRefresh: onRefresh,

            /// 有数据才能加载更多
            onLoad: listSize == 0 ? null : onLoading,
            header: ClassicalHeader(),
            footer: ClassicalFooter(),
            firstRefresh: true,
            firstRefreshWidget: listSize == 0
                ? Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    child: const Text("第一次刷新..."),
                  )
                : null,

            /// 2. 注意，无数据返回null 否则不能显示正常数据
            emptyWidget: listSize == 0
                ? Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    child: const Text("暂无数据..."),
                  )
                : null,
          );
        }),
      ),
    );
  }

  int listSize = 0;
  final requestDataCount = 0.obs;

  Future<void> onRefresh() async {
    Log.d("========onRefresh======refreshCount:${requestDataCount.value}===");
    await Future.delayed(const Duration(milliseconds: 1000));
    // 模拟第一次请求 无数据
    if (requestDataCount.value >= 1) {
      listSize = 10;
    }
    requestDataCount.value++;
    refreshController.finishRefresh();
  }

  Future<void> onLoading() async {
    Log.d("========onLoading======refreshCount:${requestDataCount.value}===");
    await Future.delayed(const Duration(milliseconds: 1000));
    // 模拟第一次请求 无数据
    if (requestDataCount.value >= 1) {
      listSize += 10;
    }
    requestDataCount.value++;
    refreshController.finishLoad();
  }
}
