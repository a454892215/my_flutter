import 'package:flutter/material.dart';

import '../../util/toast_util.dart';

String summary = '''
Clip:
1. ClipOver 圆形或者椭圆裁剪
2. ClipRRect 圆角矩形
''';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text("Clip-Sample")),
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
          child: Column(
            children: [
              ClipOval(
                  // 1. antiAlias抗锯齿裁剪 2.hardEdge不抗锯齿裁剪  3.none不裁剪
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    width: 120,
                    height: 120,
                    color: Colors.blue,
                  )),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 120,
                    height: 120,
                    color: Colors.red,
                  )),
            ],
          ));
    });
  }
}
