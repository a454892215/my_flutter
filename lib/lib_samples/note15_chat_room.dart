import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../my_widgets/chat/chat_painter.dart';
import '../util/Log.dart';

class ChatRoomTestWidget extends StatefulWidget {
  const ChatRoomTestWidget({Key? key}) : super(key: key);

  @override
  ChatRoomTestWidgetState createState() => ChatRoomTestWidgetState();
}

class ChatRoomTestWidgetState extends State<ChatRoomTestWidget> {
  ScrollController scrollController = ScrollController();

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
                  scrollController.animateTo(30000, duration: const Duration(milliseconds: 200), curve: Curves.ease);
                }),
            const Expanded(
              child: ChatWidget(
                outerBgColor: Colors.blue,
                innerBgColor: Colors.yellow,
                padding: 10,
                width: double.infinity,
                height: double.infinity,
              ),
            )
          ],
        ),
      ),
    );
  }
}
