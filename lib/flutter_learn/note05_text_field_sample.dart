import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../util/Log.dart';
import '../util/toast_util.dart';

/// 文本编辑框 TextField ，api 用法示例
class TextFieldSamplePage extends StatefulWidget {
  const TextFieldSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TextSamplePageState();
  }
}

class _TextSamplePageState extends State {
  late TextEditingController _textEditingController;

  // 控制管理焦点
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    String initText = "123";

    /// 设置文本框初始文本，并且把光标移动到最后
    _textEditingController = TextEditingController.fromValue(TextEditingValue(
        // 使光标位于文字最后
        text: initText,
        selection: TextSelection.fromPosition(TextPosition(offset: initText.length))));

    /// 添加文字变化的监听，方式 1：
    /// 1. 文本发生改变时候触发回调  2. 第一次手动获取焦点回调2次？。 动态获取焦点只回调一次
    _textEditingController.addListener(() {
      Log.d("方式 1 当前输入文字：${_textEditingController.text}");
    });

    /// 第一帧绘制完成后的回调
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // 动态获取焦点
      FocusScope.of(context).requestFocus(_focusNode);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TextFieldSamplePage")),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            buildEmptyBox(),
            TextButton(
                onPressed: () {
                  Toast.show(_textEditingController.text);
                },
                child: const Text("提交")),
            buildEmptyBox(),
            buildEditTextBox(_textEditingController, _focusNode),
            buildEmptyBox(),
            buildEditTextBox(null, null),
          ],
        ),
      ),
    );
  }

  SizedBox buildEditTextBox(TextEditingController? textEditingController, FocusNode? _focusNode) {
    return SizedBox(
      width: 320,
      height: 160,
      child: Container(
        color: const Color.fromARGB(223, 238, 238, 238),
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: textEditingController,
          focusNode: _focusNode,

          ///光标设置
          cursorColor: Colors.green,
          // cursorHeight 此高度不能过大或过小，浏览器测试，过小或者过大会显示不全或者越界
          cursorHeight: 18,
          cursorWidth: 2,
          // mouseCursor: SystemMouseCursors.text,
          // cursorRadius: null,

          /// 允许的最大输入文字长度
          maxLength: 30,

          /// 允许行数，默认1
          maxLines: 1,

          /// 光标起始位置
          textAlign: TextAlign.start,

          /// 自动获取焦点
          autofocus: false,

          /// 设置输入框是否可以编辑， 和边框显示的样式相关
          enabled: true,
          decoration: buildInputDecoration(),

          /// 密码
          // obscureText: true,

          /// 添加文字变化的监听，方式 2， 文本发生改变时候触发回调
          onChanged: (input) {
            Log.d("方式 2 input:$input");
          },

          /// 设置键盘输入类型， number，数字
          keyboardType: TextInputType.number,

          /// 键盘确定键类型，或next, done
          textInputAction: TextInputAction.done,
          inputFormatters: <TextInputFormatter>[
            /// 不能小于maxLength，
            LengthLimitingTextInputFormatter(30),
            // 只允许输入大小写字母和@_  ： RegExp(r'^[a-zA-Z0-9@_]+')
            // 只允许输入大小写字母和@_  如果出现非法字符则清空： RegExp(r'^[a-zA-Z0-9@_]+$')
            // FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9@_]+$')),
            //只允许输入中文英文数字以及-_字符,\u4E00-\u9FA5 匹配所有中文
            FilteringTextInputFormatter.allow(RegExp("[-_\u4E00-\u9FA5a-zA-Z0-96/MSP]")),

            /// 只允许输入数字
            // FilteringTextInputFormatter.allow(RegExp(r'\d+')),
          ],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            // 文字的背景
            //  backgroundColor: Color.fromARGB(255, 188, 255, 97),
          ),
        ),
      ),
    );
  }

  /// Decoration配置
  InputDecoration buildInputDecoration() {
    return const InputDecoration(
      /// label ：输入框无焦点时候优先显示 label, 获取焦点后才会显示hintText
      label: Text("用户名:"),
      labelStyle: TextStyle(color: Color.fromARGB(222, 68, 68, 68), fontSize: 14),
      hintText: "请输入用户名",
      hintStyle: TextStyle(color: Color.fromARGB(222, 168, 168, 168), fontSize: 12),

      /// 显示在输入框下面的文字
      helperText: "只能是大小写字母和_",
      helperMaxLines: 1,
      helperStyle: TextStyle(color: Color.fromARGB(255, 148, 196, 79), fontSize: 12),

      /// 和helperText显示位置相同， 如果存在，则优先显示errorText
      errorText: null,
      errorMaxLines: 1,
      errorStyle: TextStyle(color: Color.fromARGB(222, 255, 109, 109), fontSize: 12),

      /// 获取焦点后显示线输入文本的前面， prefix 和 prefixText互斥
      prefix: Text("account："),
      prefixIcon: Icon(Icons.account_circle),
      prefixStyle: TextStyle(color: Color.fromARGB(222, 128, 128, 128), fontSize: 12),

      /// 设置文本计数器提示
      counterStyle: TextStyle(color: Color.fromARGB(222, 108, 108, 108), fontSize: 12),

      /// 获取焦点后显示线输入文本的后面, suffix和suffixText互斥
      suffix: Text("后面1"),
      // suffixText: "后面",
      suffixIcon: null,
      suffixIconColor: null,
      suffixStyle: null,

      /// 去除默认下划线
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
