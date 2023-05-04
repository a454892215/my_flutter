import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../my_widgets/chat/entities.dart';
import '../my_widgets/scrollable_pos_list/refresher.dart';
import '../my_widgets/scrollable_pos_list/scrollable_positioned_list_my.dart';
import '../util/Log.dart';

int tarScrollPos = 0;

class ScrollablePositionedListTest extends StatefulWidget {
  const ScrollablePositionedListTest({Key? key}) : super(key: key);

  @override
  ChatRoomTestWidgetState createState() => ChatRoomTestWidgetState();
}

final ItemScrollController itemScrollController = ItemScrollController();

class ChatRoomTestWidgetState extends State<ScrollablePositionedListTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("自定义ChatRoomView"),
      ),
      body: Column(
        children: [
          const Expanded(child: ChatWidget()),
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
    );
  }
}

class ChatWidget extends StatefulWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChatWidget2State();
  }
}

class ChatWidget2State extends State {
  final List<ChatMessage> dataList = getTestData(size: 3);
  RefresherController refController = RefresherController();

  @override
  Widget build(BuildContext context) {
    bool isReverse = true;
    return RefresherIndexListWidget(
      dataList: dataList,
      itemBuilder: buildItemWidget,
      itemScrollController: itemScrollController,
      refresherController: refController,
      isReverse: isReverse,
      onFooterStartLoad: () {},
      onHeaderStartLoad: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        if (isReverse) {
          dataList.addAll(getTestData(size: 2));
          refController.notifyHeaderLoadFinish();
        } else {
          dataList.clear();
          dataList.addAll(getTestData(size: 10));
          refController.notifyHeaderLoadFinish();
        }

        Log.d("===========onHeaderStartLoad================");
      },
    );
  }

  Widget buildItemWidget(BuildContext context, int index) {
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
