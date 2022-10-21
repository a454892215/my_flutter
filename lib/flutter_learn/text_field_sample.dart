import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../util/Log.dart';

class TextFieldSamplePage extends StatefulWidget {
  const TextFieldSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TextSamplePageState();
  }
}

class _TextSamplePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TextFieldSamplePage")),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            buildEmptyBox(),
            SizedBox(
              width: 260,
              height: 160,
              child: Container(
                color: const Color.fromARGB(222, 227, 227, 227),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  // 允许的最大输入文字长度
                  maxLength: 30,
                  // 允许行数，默认1
                  maxLines: 1,
                  // 光标起始位置
                  textAlign: TextAlign.center,
                  // 自动获取焦点
                  autofocus: false,
                  // 设置输入框是否可以编辑， 和边框显示的样式相关
                  enabled: true,
                  decoration: buildInputDecoration(),
                  // 密码
                  // obscureText: true,

                  onChanged: (input) {
                    Log.d("input:$input");
                  },
                  // 设置键盘输入类型， number，数字
                  keyboardType: TextInputType.number,
                  // 键盘确定键类型，或next, done
                  textInputAction: TextInputAction.done,
                  inputFormatters: <TextInputFormatter>[
                    // 不能小于maxLength，
                    LengthLimitingTextInputFormatter(30),
                    // 只允许输入大小写字母和@_  ： RegExp(r'^[a-zA-Z0-9@_]+')
                    // 只允许输入大小写字母和@_  如果出现非法字符则清空： RegExp(r'^[a-zA-Z0-9@_]+$')
                    // FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9@_]+$')),
                    //只允许输入中文英文数字以及-_字符,待测试
                    FilteringTextInputFormatter.allow(RegExp("[-_\u4E00-\u9FA5a-zA-Z0-96/MSP]")),
                    // 只允许输入数字
                    // FilteringTextInputFormatter.allow(RegExp(r'\d+')),
                  ],
                  style: const TextStyle(
                    // 文字的背景
                    backgroundColor: Color.fromARGB(255, 188, 255, 97),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 各种状态的边框配置
  InputDecoration buildInputDecoration() {
    return const InputDecoration(
      // 渠道默认下划线
      // border: InputBorder.none,
      //上下左右都有边框

      // enabled=true, 无焦点的border样式
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          //设置边框颜色和粗细(width)
          borderSide: BorderSide(color: Colors.white, width: 2)),

      // enabled=false, border样式
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          //设置边框颜色和粗细(width)
          borderSide: BorderSide(color: Colors.grey, width: 2)),

      // This property is only used when the appropriate one of [errorBorder],
      // [focusedBorder], [focusedErrorBorder], [disabledBorder], or [enabledBorder] is not specified.
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          //设置边框颜色和粗细(width)
          borderSide: BorderSide(color: Colors.green, width: 2)),

      // 有焦点的border样式
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          //设置边框颜色和粗细(width)
          borderSide: BorderSide(color: Colors.blue, width: 2)),

      // 输入错误的border
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          //设置边框颜色和粗细(width)
          borderSide: BorderSide(color: Colors.red, width: 2)),
    );
  }

  SizedBox buildEmptyBox() {
    return const SizedBox(width: 0, height: 20);
  }
}
