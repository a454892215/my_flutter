import 'package:flutter/material.dart';

class ImageSamplePage extends StatefulWidget {
  const ImageSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StackAndWrap-示例"),
      ),
      body: ListView(
        children: [
          buildContainer1(),
        ],
      ),
    );
  }

  double itemWidth = 30;

  /// 绝对定位： Stack， Positioned
  Container buildContainer1() {
    return Container(
      height: 100,
      color: Colors.orange,
      child: Stack(
        //  StackFit.expand 没有Positioned定位的子空间填充满窗口
        // fit: StackFit.expand,
        children: [
          Positioned(
            width: itemWidth,
            height: itemWidth,
            left: 10,
            top: 10,
            child: Container(color: Colors.pink),
          ),
          Positioned(
            width: itemWidth,
            height: itemWidth,
            right: 10,
            top: 10,
            child: Container(color: Colors.grey),
          ),

          /// 怎么居中？？？
          Positioned(
            width: 100,
            height: itemWidth,
            left: 10,
            bottom: 10,
            child: Container(color: Colors.blue),
          ),
        ],
      ),
    );
  }

}
