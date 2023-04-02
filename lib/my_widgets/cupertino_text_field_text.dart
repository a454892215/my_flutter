import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 因为CupertinoTextField和Text在不同的手机上面对齐的时候存在适配兼容问题 故使用此控件代替Text控件
class CupertinoTextFieldText extends StatefulWidget {
  final TextStyle? textStyle;
  final String text;
  final BoxDecoration? decoration;

  const CupertinoTextFieldText({
    super.key,
    this.textStyle,
    required this.text,
    this.decoration,
  });

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<CupertinoTextFieldText> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CupertinoTextField(
            controller: textEditingController,
            enabled: true,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.start,
            style: widget.textStyle,
            padding: EdgeInsets.zero,
            decoration: widget.decoration,
          ),

          /// 因为 CupertinoTextField的 enabled: 一旦设置为false有灰色背景而且无法找到去掉的方法，
          /// 故enabled设置为true, 在CupertinoTextField上面盖一层避免被编辑
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
          )
        ],
      ),
    );
  }
}
