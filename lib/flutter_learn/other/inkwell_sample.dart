import 'package:flutter/material.dart';

import '../../util/toast_util.dart';

String summary = '''
InkWell:
1. InkWell 的子控件设置颜色会覆盖水波纹效果，可以把颜色背景设置给InkWell的父控件，比如Ink
2. Ink 的decoration 可以定义形状，防止水波纹越界
''';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text("InkWell")),
      body: const _TestWidget(),
    ),
  ));
}

class _TestWidget extends StatefulWidget {
  const _TestWidget();

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Align(
        alignment: Alignment.topCenter,

        ///1. 定义一个带有水波纹的蓝色圆角按钮
        child: Ink(
          width: 120,
          height: 40,
          decoration: BoxDecoration(color: Colors.blue[500], borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: InkWell(
              onTap: () {
                Toast.show("你好啊啊啊啊啊");
              },
              splashColor: Colors.blue[700],
              /// 水波纹颜色
             // splashColor: Colors.transparent,

              /// 按下的颜色
              // highlightColor: Colors.blue[700],
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              /// 设置水波纹扩散大小， 此大小一般应该大于2倍按钮长度，否则波纹不能完全扩散到按钮上
              radius: 120,
              child: const Center(
                  child: Text(
                "Ink按钮一号",
                style: TextStyle(color: Colors.white),
              ))),
        ),
      );
    });
  }
}
