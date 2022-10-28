import 'package:flutter/material.dart';

import '../../util/Log.dart';

String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: _Page(),
  ));
}

/// 1. MouseRegion 和 RenderBox 获取组件的位置和大小信息
class _Page extends StatefulWidget {
  const _Page();

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text("按钮"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            MouseRegion(
              onEnter: (value) {
                RenderBox? renderObject = _key.currentContext!.findRenderObject() as RenderBox?;
                Size? size = renderObject?.size;
                Offset? offset = renderObject?.localToGlobal(Offset.zero);
                // dx, dy 是相对屏幕左边和顶边的位置
                var dx = offset?.dx;
                var dy = offset?.dy;
                Log.d("onEnter size:$size dx:$dx dy:$dy");
              },
              onExit: (value) {
                Log.d("onExit");
              },
              onHover: (value) {
               // Log.d("onHover");
              },
              child: Container(width: 120, height: 80, color: Colors.blue, key: _key,),
            ),
          ],
        ),
      ),
    );
  }
}
