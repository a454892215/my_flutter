import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../util/Log.dart';
import '../util/measure_util.dart';

class WidgetMeasurePage extends StatefulWidget {
  const WidgetMeasurePage({Key? key}) : super(key: key);

  @override
  State createState() => MyState();
}

class MyState extends State<WidgetMeasurePage> {
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  List<String> picList = [
    "banner1.webp",
    "banner2.webp",
    "banner3.webp",
    "banner4.webp",
  ];

  final Map<int, double> _itemHeights = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 200; i++) {
      var picPath = "images/${picList[i % 4]}";
      _messages.add(Message(content: "$i-Hello", sender: "Alice", pic: picPath));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("测量带有图片的控件大小验证2"),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          return MessageItemWidget(
            message: _messages[index],
            index: index,
            onHeightChanged: (height) {
              _itemHeights[index] = height;
            },
          );
        },
      ),
    );
  }
}

class Message {
  final String content;
  final String sender;
  final String pic;

  Message({
    required this.content,
    required this.sender,
    required this.pic,
  });
}

class MessageItemWidget extends StatefulWidget {
  final Message message;
  final int index;
  final Function(double) onHeightChanged;

  const MessageItemWidget({
    Key? key,
    required this.message,
    required this.onHeightChanged,
    required this.index,
  }) : super(key: key);

  @override
  MessageItemState createState() => MessageItemState();
}

class MessageItemState extends State<MessageItemWidget> {
  WidgetSizeHelper widgetSizeHelper = WidgetSizeHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// 含有图片直接设置是获取不到widget准确大小的
    widgetSizeHelper.addListener((size) {
      Log.d("index:${widget.index} 测量大小是：${widgetSizeHelper.getSize()} ");
    });
    return LayoutBuilder(
        key: widgetSizeHelper.globalKey,
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            color: const Color(0xff387fde),
            child: Column(
              children: [
                Stack(children: [
                  Image.asset(widget.message.pic, width: 800.w),
                ]),
                const SizedBox(height: 10),
                Text(widget.message.content),
              ],
            ),
          );
        });
  }
}
