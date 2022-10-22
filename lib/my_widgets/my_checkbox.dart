import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _MyCheckBoxState();
  }
}

class _MyCheckBoxState extends State<MyCheckBox> {
  late Image selectedImg;
  late Image unselectedImg;
  bool checked = false;

  @override
  void initState() {
    selectedImg = Image.asset(
      'images/check/ic_checked.png',
      width: 50,
      gaplessPlayback: true,
    );
    unselectedImg = Image.asset(
      'images/check/ic_uncheck.png',
      width: 50,
      gaplessPlayback: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color curColor = checked ? Colors.green : Colors.black;
    Image curImage = checked ? selectedImg : unselectedImg;

    /// GestureDetector无点击水波纹效果 InkWell有 。第一次点击会抖动一下？
    return InkWell(
      child: Column(
        children: [
          curImage,
          Text(
            widget.title,
            style: TextStyle(color: curColor),
          )
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
