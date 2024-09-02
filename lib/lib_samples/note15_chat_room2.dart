import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../my_widgets/chat/entities.dart';
import '../util/Log.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

final List<ChatMessage> dataList = getTestData(size: 40000);

class ChatRoomTest12Widget extends StatefulWidget {
  const ChatRoomTest12Widget({Key? key}) : super(key: key);

  @override
  ChatRoomTestWidgetState createState() => ChatRoomTestWidgetState();
}


// ListObserverController observerController = ListObserverController(controller: scrollController);

class ChatRoomTestWidgetState extends State<ChatRoomTest12Widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("自定义 ChatRoomView 1.2"),
      ),
      body: Column(
        children: [
          CupertinoButton(
              child: const Text("滚动到指定位置"),
              onPressed: () {
                //scrollController.animateTo(30000, duration: const Duration(milliseconds: 200), curve: Curves.ease);
                tarScrollPos = 20000;
              //  observerController.jumpTo(index: tarScrollPos);
                 controller.scrollToIndex(tarScrollPos, preferPosition: AutoScrollPosition.begin);
              }),
          Expanded(child: ListViewChatWidget()),
          Container(
            width: double.infinity,
            height: 50,
            color: Colors.yellow,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Expanded(child: TextField(
                  onChanged: (String? text) {
                    var chatMessage = ChatMessage();
                    chatMessage.text = "$text";
                    dataList.insert(0, chatMessage);
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
    );
  }
}

var tarScrollPos = 0;

class ListViewChatWidget extends StatefulWidget {
  const ListViewChatWidget({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _MyListViewWidgetState();
  }
}
late AutoScrollController controller;

class _MyListViewWidgetState extends State<ListViewChatWidget> {
  final scrollDirection = Axis.vertical;

  final int initialIndex = 50;


  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(keepScrollOffset: false);
    // 在initState中设置初始滚动位置
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(initialIndex);
    });
  }

  Future _scrollToIndex(int index) async {
    await controller.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      cacheExtent: 3.sh,
      itemBuilder: (BuildContext context, int index) {
        if (tarScrollPos > -1 && (tarScrollPos - index).abs() > 5) {
          return const SizedBox();
        }
        tarScrollPos = -1;
        ChatMessage item = dataList[index];
        return AutoScrollTag(
          key: ValueKey(index),
          controller: controller,
          index: index,
          child: Container(
            color: const Color(0xffcccccc),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Column(
              children: [
                Text("$index. ${item.text}",
                    style:
                    const TextStyle(fontSize: 14, color: Colors.black)),
                for (int i = 0; i < 1; i++)
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Image.asset(item.imgList[i]),
                  )
              ],
            ),
          ),
        );
      },
      itemCount: dataList.length,
    );
  } // 设置初始显示的索引
}

List<ChatMessage> getTestData({int size = 300}) {
  List<ChatMessage> list = [];
  for (int i = 0; i < size; i++) {
    var chatMessage = ChatMessage();
    chatMessage.text = generateRandomChineseString();
    chatMessage.userIcon = "";
    var next1 = Random().nextInt(11);
    var next2 = Random().nextInt(11);
    chatMessage.imgList = [
      "images/chat/chat$next1.jpg",
      "images/chat/chat$next2.jpg"
    ];
    list.add(chatMessage);
  }
  return list;
}

String generateRandomChineseString() {
  final random = Random();
  final length = random.nextInt(109) + 12; // 生成12到120之间的随机数
  final buffer = StringBuffer();

  for (int i = 0; i < length; i++) {
    final unicode = random.nextInt(20901) + 19968;
    final character = String.fromCharCode(unicode);
    buffer.write(character);
  }

  final chineseString = buffer.toString();
  return chineseString;
}
