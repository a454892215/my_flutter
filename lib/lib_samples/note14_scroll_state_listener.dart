import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/Log.dart';

class ScrollStateListenerTestWidget extends StatefulWidget {
  const ScrollStateListenerTestWidget({Key? key}) : super(key: key);

  @override
  ObxNestTestWidgetState createState() => ObxNestTestWidgetState();
}

class ObxNestTestWidgetState extends State<ScrollStateListenerTestWidget> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("滚动状态监听"),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          switch (notification.runtimeType) {
            case ScrollStartNotification:
              Log.d("开始滚动");
              break;
            case ScrollUpdateNotification:
              Log.d("正在滚动");
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
        child: Column(children: [
          CupertinoButton(child: const Text("滚动到指定位置"), onPressed: (){
            scrollController.animateTo(30000, duration: const Duration(milliseconds: 200), curve: Curves.ease);
           // scrollController.jumpTo(40000);
          }),
          Expanded(child: ListView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            children: [
              ...List.generate(
                  1000,
                      (index) => Container(
                    height: 50,
                    width: double.infinity,
                    color: index % 2 == 0 ? Colors.red : Colors.blue,
                    alignment: Alignment.center,
                    child: Text("Text:$index", style: const TextStyle(color: Colors.white),),
                  )).toList()
            ],
          ))
        ],),
      ),
    );
  }
}
