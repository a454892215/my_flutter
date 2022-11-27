import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

import '../util/Log.dart';

String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    title: "PageView Sample",
    home: _Page(),
  ));
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State with SingleTickerProviderStateMixin {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    Log.d("============initState=============");
    controller = PageController(initialPage: 4);
    // 只在页面滚动结束后，才会回调一次
    controller.addListener(() {
      // page  当前显示的页面滚动占比
      Log.d("page:${controller.page} ");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PageView Sample"),
      ),
      body: PageView(
        controller: controller,
        onPageChanged: (value){
          Toast.show(value);
        },
        children: [getPage("页面0", Colors.green), getPage("页面1", Colors.blue), getPage("页面2", Colors.yellow), getPage("页面3", Colors.orange)],
      ),
    );
  }

  Widget getPage(String text, Color bgColor) {
    return Container(
      alignment: Alignment.center,
      color: bgColor,
      child: Text(text),
    );
  }
}
