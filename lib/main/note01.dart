/*
01. dart类声明语法：
class class_name {
   <fields>
   <getters/setters>
   <constructors>
   <functions>
}

02. dart 函数声明不需要任何关键字
void test(){
}

03. dart变量声明关键词 var
* */

import 'package:flutter/material.dart';

import '../util/toast_util.dart';

/// 01.简单的widget示例， flutter一切UI相关组件都是widget的子类，UI相关的尺寸大小，颜色，margin,padding,事件也是widget
Widget getWidget01() {
  return Container(
    // 一个容器 widget
    color: Colors.blue, // 设置容器背景色
    child: Row(
      children: [
        GestureDetector(
            onTap: () {
              // 添加点击
              Toast.toast("你好啊！");
            },
            child: const Text('B')),
        const Image(image: AssetImage("images/js.jpeg"), width: 400.0),
        const Text('A'),
      ],
    ),
  );
}

/// 02. 简单的 StatelessWidget示例
class StatelessWidget01 extends StatelessWidget {
  const StatelessWidget01({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {  Toast.toast("你好啊！");},
      //监听更多方法可以在这里添加
      child: const Center(
        child: Text(
          "简单的 StatelessWidget 示例",
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}

/// 03. 简单的 StatefulWidget 示例： StatefulWidget需要配合 State 使用
class StatefulWidget02 extends StatefulWidget {
  const StatefulWidget02({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State01();
  }
}

/// 04. 简单的 State 示例
class _State01 extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("简单的 State 示例!");
  }
}
