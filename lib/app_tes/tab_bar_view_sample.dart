import 'package:flutter/material.dart';

import '../util/Log.dart';

String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    title: "ViewPager Sample",
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
  late TabController controller = TabController(length: 4, vsync: this);

  @override
  void initState() {
    Log.d("============initState=============");
    // 只在页面滚动结束后，才会回调一次
    controller.addListener(() {
    //  Log.d("index:${controller.index}   ${controller.offset}");
    });
    // 可以监听到页面滚动的详细情况
    controller.animation?.addListener(() {
      Log.d("index:${controller.index}   ${controller.offset}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ViewPager Sample"),
      ),
      body: TabBarView(
        controller: controller,
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
