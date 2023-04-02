import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/text_util.dart';

import '../util/Log.dart';
import '../util/measure_util.dart';

class TextMeasureWidget extends StatefulWidget {
  const TextMeasureWidget({Key? key}) : super(key: key);

  @override
  TextMeasureWidgetState createState() => TextMeasureWidgetState();
}

class TextMeasureWidgetState extends State<TextMeasureWidget> {
  String text = "Hello, World!\nThis is a new line. fdafdf dfaf dfasfas fdfaf dfdasdf fdffa fasf";
  TextStyle textStyle = const TextStyle(fontSize: 17.0, color: Colors.white);
  double maxWidth = 200;

  @override
  void initState() {
    super.initState();
    var textSize = getTextSize(text: text, style: textStyle, maxWidth: maxWidth);
    Log.d("====== measure textSize:$textSize=============");
  }

  WidgetSizeHelper widgetSizeHelper = WidgetSizeHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Column(
        children: [
          CupertinoButton(
              child: Container(
                key: widgetSizeHelper.globalKey,
                width: maxWidth,
                color: Colors.blue,
                child: Text(
                  text,
                  style: textStyle,
                ),
              ),
              onPressed: () {
                var textSize = getTextSize(text: text, style: textStyle, maxWidth: maxWidth);
                Log.d("====== measure textSize:$textSize=============");
                Log.d("======real size:${widgetSizeHelper.getSize()}=============");
              })
        ],
      ),
    );
  }
}
