import 'package:flutter/material.dart';

main() {
  runApp(const MaterialApp(
    home: StackAndWrapSamplePage(),
  ));
}

class StackAndWrapSamplePage extends StatefulWidget {
  const StackAndWrapSamplePage({super.key});

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
          const Padding(padding: EdgeInsets.all(5)),
          buildContainer3(),
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
        alignment: Alignment.center,
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

          Positioned(
            width: 100,
            height: itemWidth,
            left: 10,
            bottom: 10,
            child: Container(color: Colors.blue),
          ),

          /// 居中 未定位子控件根据stack的alignment定位
          Container(
            width: 50,
            height: 50,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  /// 流式布局： Wrap
  Container buildContainer3() {
    return Container(
      height: 100,
      color: Colors.orange,
      child: Wrap(
        spacing: 8.0, // 主轴(水平)方向间距
        runSpacing: 4.0, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.center, //沿主轴方向居中
        children: const <Widget>[
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
            label: Text('Hamilton'),
          ),
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
            label: Text('Lafayette'),
          ),
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
            label: Text('Mulligan'),
          ),
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
            label: Text('Laurens'),
          ),
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
            label: Text('Sandy'),
          ),
        ],
      ),
    );
  }
}
