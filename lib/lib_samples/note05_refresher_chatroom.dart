import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresher.dart';
import '../my_widgets/refresher/my_physics.dart';
import '../my_widgets/refresher/refresh_state.dart';

class RefresherChatRoomPage extends StatefulWidget {
  const RefresherChatRoomPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    refreshDataForList(20);
  }

  final bool isReverseScroll = true;
  final ScrollController sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SmartRefresher-ChatRoom模式"),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Expanded(child: LayoutBuilder(
              builder: (context, constraint) {
                double refresherContentHeight = constraint.maxHeight;
                double refresherContentWidth = constraint.maxWidth;
                return Refresher(
                    sc: sc,
                    height: refresherContentHeight,
                    width: refresherContentWidth,
                    isReverseScroll: isReverseScroll,
                    controller: RefresherController(),
                    headerFnc: RefresherFunc.load_more,
                    footerFnc: RefresherFunc.refresh,
                    onHeaderLoad: (state) async {
                      await Future.delayed(const Duration(milliseconds: 1000));
                      loadMoreDataForList(10);
                      listView2Notifier.value++;
                      state.notifyHeaderLoadFinish();
                    },
                    onFooterLoad: (state) async {
                      await Future.delayed(const Duration(milliseconds: 1000));
                      refreshDataForList(10);
                      listView2Notifier.value++;
                      state.notifyFooterLoadFinish();
                    },
                    child: Container(
                      height: refresherContentHeight,
                      width: refresherContentWidth,
                      color: const Color(0xffaeeeae),
                      child: buildListView2(sc),
                    ));
              },
            )),
          ],
        ),
      ),
    );
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
              reverse: isReverseScroll,
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
                return Container(
                  height: 60,
                  color: const Color(0xffb9e8b9),
                  alignment: Alignment.center,
                  child: Text(text),
                );
              });
        });
  }

  void loadMoreDataForList(int size) {
    for (int i = 0; i < size; i++) {
      list2.add("data");
    }
  }

  void refreshDataForList(int size) {
    list2.clear();
    for (int i = 0; i < size; i++) {
      list2.add("data");
    }
  }
}
