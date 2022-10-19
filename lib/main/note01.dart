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
import 'package:my_flutter_lib_3/util/Log.dart';

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

/// 02. 简单的 StatelessWidget 示例， StatelessWidget需要重写Widget build(BuildContext context)函数
class StatelessWidget01 extends StatelessWidget {
  const StatelessWidget01({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Toast.toast("你好啊！");
      },
      //监听更多方法可以在这里添加
      child: const Center(
        child: Text(
          "简单的 StatelessWidget 示例",
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }

  @override
  StatelessElement createElement() {
    return super.createElement();
  }
}

/// 03. 简单的 StatefulWidget 示例： StatefulWidget 需要重写createState()函数  返回State配合使用
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

///05. Echo 使用示例， 构造函数传参示例, Center示例
class EchoWidget extends StatelessWidget {
  const EchoWidget({
    Key? key,
    required this.text,
    this.backgroundColor = Colors.grey, //默认为灰色
  }) : super(key: key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // Container的大小会包裹内容大小
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}

///06. findAncestorWidgetOfExactType 获取父节点的使用使用
class ContextRoute extends StatelessWidget {
  const ContextRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Context测试"),
      ),
      body: Builder(builder: (context) {
        // 在 widget 树中向上查找最近的父级`Scaffold`  widget
        dynamic widget = context.findAncestorWidgetOfExactType<Scaffold>();
        // 直接返回 AppBar的title， 此处实际上是Text("Context测试")
       // Toast.toast(widget);
        Widget? title = (widget.appBar as AppBar).title;
        return title!;
      }),
    );
  }
}
