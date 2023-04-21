import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../my_widgets/chat/chat_painter.dart';
import '../util/Log.dart';

class ChatRoomTestWidget extends StatefulWidget {
  const ChatRoomTestWidget({Key? key}) : super(key: key);

  @override
  ChatRoomTestWidgetState createState() => ChatRoomTestWidgetState();
}

ScrollController scrollController = ScrollController();
ListObserverController observerController = ListObserverController(controller: scrollController);
class ChatRoomTestWidgetState extends State<ChatRoomTestWidget> {
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
            CupertinoButton(
                child: const Text("滚动到指定位置"),
                onPressed: () {
                  //scrollController.animateTo(30000, duration: const Duration(milliseconds: 200), curve: Curves.ease);
                  observerController.jumpTo(index: 20000);
                }),
            Expanded(
              child: ListViewObserver(
                  controller: observerController,
                  child: ChatWidget2()),
            )
          ],
        ),
      ),
    );
  }
}

class ChatWidget1 extends StatelessWidget {
  const ChatWidget1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ChatWidget(
      outerBgColor: Colors.blue,
      innerBgColor: Colors.yellow,
      padding: 10,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

class ChatWidget2 extends StatelessWidget {
  ChatWidget2({Key? key}) : super(key: key);

  final List<ChatMessage> list = getTestData();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      cacheExtent: 600 * 100,
      itemBuilder: (BuildContext context, int index) {
        ChatMessage item = list[index];
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
      itemCount: list.length,
    );
  }
}

class ChatMessage {
  String text = "";
  List<String> imgList = [];
  String userIcon = "";
}

List<ChatMessage> getTestData() {
  List<ChatMessage> list = [];
  for (int i = 0; i < 50000; i++) {
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
