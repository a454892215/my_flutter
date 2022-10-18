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

Container getWidget01() {
  return Container(
    // 一个容器 widget
    color: Colors.blue, // 设置容器背景色
    child: Row(
      // 可以将子widget沿水平方向排列
      children: const [
        Image(image: AssetImage("images/js.jpeg"), width: 400.0),
        Text('A'),
      ],
    ),
  );
}
