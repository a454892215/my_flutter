import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull_refresh;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../my_widgets/chat/entities.dart';
import '../util/Log.dart';

final List<ChatMessage> dataList = getTestData(size: 10000);
final dataSize = dataList.length.obs;
int tarScrollPos = 0;

class ChatRoomTest2Widget extends StatefulWidget {
  const ChatRoomTest2Widget({Key? key}) : super(key: key);

  @override
  ChatRoomTestWidgetState createState() => ChatRoomTestWidgetState();
}

final ItemScrollController itemScrollController = ItemScrollController();

class ChatRoomTestWidgetState extends State<ChatRoomTest2Widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("自定义ChatRoomView"),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          switch (notification.runtimeType) {
            case ScrollStartNotification:
              Log.d("开始滚动");
              break;
            case ScrollUpdateNotification:
              //  Log.d("正在滚动");
              break;
            case ScrollEndNotification:
              Log.d("滚动停止");
              break;
            case OverscrollNotification:

              /// 如果有 BouncingScrollPhysics 会无边界
              Log.d("滚动到边界");
              break;
          }
          return true;
        },
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 20),
                CupertinoButton(
                    color: Colors.grey,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      itemScrollController.scrollTo(
                        index: tarScrollPos += 5000,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOutCubic,
                      );
                    },
                    child: const Text("滚动到下个5000")),
                const SizedBox(width: 10),
                CupertinoButton(
                    color: Colors.grey,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      List<ChatMessage> newList = getTestData(size: 5000);
                      dataList.addAll(newList);
                      dataSize.value = dataList.length;
                    },
                    child: const Text("新增 5000 条数据")),
                const SizedBox(width: 10),
                Obx(() => Text("总数据量:${dataSize.value}")),
              ],
            ),
            const Expanded(child: ChatWidget1()),
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.yellow,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(child: TextField(
                    onChanged: (String? text) {
                      try {
                        if (text != null && text.isNotEmpty) {
                          int pos = int.parse(text);
                          itemScrollController.scrollTo(
                            index: pos,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOutCubic,
                          );
                          Log.d("==============itemScrollController======pos:$pos=========");
                        }
                      } catch (e) {
                        // toast(e.toString());
                        Log.e("e:$e");
                      }
                    },
                  )),
                  CupertinoButton(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      color: Colors.grey,
                      onPressed: () {
                        Log.d("===================");
                      },
                      child: const Text("发送")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 1. 无下拉刷新的 ScrollablePositionedList.builder
class ChatWidget1 extends StatelessWidget {
  const ChatWidget1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ScrollablePositionedList.builder(
          itemScrollController: itemScrollController,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            ChatMessage item = dataList[index];
            return Container(
              color: const Color(0xffcccccc),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Column(
                children: [
                  Text("$index. ${item.text}", style: const TextStyle(fontSize: 14, color: Colors.black)),
                  for (int i = 0; i < 1; i++)
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Image.asset(item.imgList[i]),
                    )
                ],
              ),
            );
          },
          itemCount: dataSize.value,
        ));
  }
}

/// 2. 添加EasyRefresh.custom 后不能滚动到指定item
class ChatWidget2 extends StatefulWidget {
  const ChatWidget2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChatWidget2State();
  }
}

class ChatWidget2State extends State {
  final dataSize2 = 50.obs;
  var listener = ItemPositionsListener.create();
  final _sc = ScrollController(keepScrollOffset: false);

  @override
  void initState() {
    listener.itemPositions.addListener(() {
      var currentIndex = listener.itemPositions.value.elementAt(0).index;
      Log.d("currentIndex:$currentIndex");
    });
    _sc.addListener(() {
      Log.d("======_sc:${_sc.position.pixels}==========");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => EasyRefresh.custom(
          //header: ClassicalHeader(),
          // footer: ClassicalFooter(),
          onRefresh: () async {},
          onLoad: () async {},
          scrollController: _sc,
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: ScrollablePositionedList.builder(
                itemScrollController: itemScrollController,
                itemPositionsListener: listener,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  ChatMessage item = dataList[index];
                  return Container(
                    color: const Color(0xffcccccc),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Column(
                      children: [
                        Text("$index. ${item.text}", style: const TextStyle(fontSize: 14, color: Colors.black)),
                        for (int i = 0; i < 1; i++)
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Image.asset(item.imgList[i]),
                          )
                      ],
                    ),
                  );
                },
                itemCount: dataSize2.value,
              ),
            )

            // SliverList(
            //   delegate: SliverChildBuilderDelegate((context, listIndex) {
            //     return Container(
            //       width: double.infinity,
            //       height: 80,
            //       color: Colors.blue,
            //       margin: const EdgeInsets.only(bottom: 10),
            //     );
            //   }, childCount: dataSize.value),
            // ),
          ],
        ));
  }
}

/// 3. 使用 RefreshIndicator 实现的下拉刷新
class ChatWidget3 extends StatelessWidget {
  ChatWidget3({Key? key}) : super(key: key);
  final dataSize2 = 50.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => RefreshIndicator(
          onRefresh: () async {
            Log.d("============实现了下拉刷新=============");
          },
          child: ScrollablePositionedList.builder(
            physics: const BouncingScrollPhysics(),
            itemScrollController: itemScrollController,
            shrinkWrap: true,
            //  reverse: true,
            itemBuilder: (BuildContext context, int index) {
              ChatMessage item = dataList[index];
              return Container(
                color: const Color(0xffcccccc),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    Text("$index. ${item.text}", style: const TextStyle(fontSize: 14, color: Colors.black)),
                    for (int i = 0; i < 1; i++)
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Image.asset(item.imgList[i]),
                      )
                  ],
                ),
              );
            },
            itemCount: dataSize2.value,
          ),
        ));
  }
}

/// 4. 使用 SmartRefresher 实现的下拉刷新, 需要 shrinkWrap: true, 数据量过大会直接卡死
class ChatWidget4 extends StatelessWidget {
  ChatWidget4({Key? key}) : super(key: key);
  final dataSize2 = 50.obs;
  final controller = pull_refresh.RefreshController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => pull_refresh.SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const pull_refresh.ClassicHeader(
            refreshingIcon: CupertinoActivityIndicator(),
            height: 60,
          ),
          footer: const pull_refresh.ClassicFooter(
            loadingIcon: CupertinoActivityIndicator(),
            height: 90,
            loadStyle: pull_refresh.LoadStyle.ShowWhenLoading,
          ),
          controller: controller,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 300));
            controller.refreshCompleted();
          },
          onLoading: () async {
            await Future.delayed(const Duration(milliseconds: 300));
            controller.loadComplete();
          },
          child: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemBuilder: (BuildContext context, int index) {
              ChatMessage item = dataList[index];
              return Container(
                color: const Color(0xffcccccc),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    Text("$index. ${item.text}", style: const TextStyle(fontSize: 14, color: Colors.black)),
                    for (int i = 0; i < 1; i++)
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Image.asset(item.imgList[i]),
                      )
                  ],
                ),
              );
            },
            itemCount: dataSize.value,
          ),
        ));
  }
}

List<ChatMessage> getTestData({int size = 300}) {
  List<ChatMessage> list = [];
  for (int i = 0; i < size; i++) {
    var chatMessage = ChatMessage();
    chatMessage.text = generateRandomChineseString();
    chatMessage.userIcon = "";
    var next1 = Random().nextInt(11);
    var next2 = Random().nextInt(11);
    chatMessage.imgList = ["images/chat/chat$next1.jpg", "images/chat/chat$next2.jpg"];
    list.add(chatMessage);
  }
  return list;
}

String generateRandomChineseString() {
  final random = Random();
  final length = random.nextInt(409) + 12; // 生成12到120之间的随机数
  final buffer = StringBuffer();

  for (int i = 0; i < length; i++) {
    final unicode = random.nextInt(20901) + 19968;
    final character = String.fromCharCode(unicode);
    buffer.write(character);
  }

  final chineseString = buffer.toString();
  return chineseString;
}
