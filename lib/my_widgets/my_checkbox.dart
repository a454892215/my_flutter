import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return MyCheckBoxState();
  }
}

class MyCheckBoxState extends State<MyCheckBox> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    String iconPath = checked ? 'images/check/ic_checked.png' : 'images/check/ic_uncheck.png';
    Color curColor = checked ? Colors.green : Colors.black;

    /// GestureDetector无点击水波纹效果 InkWell有 。第一次点击会抖动一下？
    return InkWell(
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: 50,
          ),
          Text(widget.title, style: TextStyle(color: curColor),)
        ],
      ),
      onTap: () {
        setState(() {
          checked = !checked;
        });
      },
    );
  }
}
