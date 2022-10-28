import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/Log.dart';

String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: _Page(),
  ));
}

/// LayoutBuilder MediaQueryData， 键盘顶布局处理，适配性待验证...
class _Page extends StatefulWidget {
  const _Page();

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
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
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            MediaQueryData mediaQueryData = MediaQuery.of(context);
            // 底部遮挡部分
            EdgeInsets padding = mediaQueryData.padding;
            // 顶部遮挡部分
            EdgeInsets viewPadding = mediaQueryData.viewPadding;
            // 键盘高度
            EdgeInsets viewInsets = mediaQueryData.viewInsets;
            double itemWidth = 120;
            double itemHeight = 120;
            double centerLeft = getCenterLeft(constraints.maxWidth, itemWidth);
            double centerTop = (constraints.maxHeight - itemHeight) / 2.0;
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 10,
                  left: getCenterLeft(constraints.maxWidth, itemWidth * 2),
                  child: Container(
                    width: itemWidth * 2,
                    height: itemHeight,
                    color: Colors.pink,
                    alignment: Alignment.center,
                    child: Text(
                      "padding:${padding.bottom}  viewPadding: ${viewPadding.bottom}"
                      " viewInsets:${viewInsets.bottom}",
                      softWrap: true,maxLines: 2,
                    ),
                  ),
                ),
                Positioned(
                  top: centerTop,
                  left: centerLeft,
                  child: Container(
                    width: itemWidth,
                    height: itemHeight,
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  bottom: 10 + padding.bottom + viewInsets.bottom,
                  left: centerLeft,
                  child: Container(
                    width: itemWidth,
                    height: itemHeight,
                    color: Colors.transparent,
                    child: const TextField(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  double getCenterLeft(double parentWidth, double selfWidth) {
    return (parentWidth - selfWidth) / 2.0;
  }
}
