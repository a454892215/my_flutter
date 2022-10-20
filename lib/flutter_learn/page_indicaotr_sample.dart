import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/Log.dart';

main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FloatActionSample",
      home: MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => SelectorNotifier())],
        child: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

/// SingleTickerProviderStateMixin 只能被State的实现类with
class MainPageState extends State with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    Log.d("======对象创建后之会被调用一次====");
    controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Float_Action_button_Sample"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(28), // 不占用AppBar的高度，自己扩展出新高度
          child: Container(
            height: 28,
            color: Colors.grey,
          ),
        ),
      ),
      bottomSheet: Container(
        height: 30,
        color: Colors.white,
        child: Center(
          /// 显示indicator列表 items
          child: TabPageSelector(
            controller: controller,
            indicatorSize: 7,
            color: Colors.grey,
            selectedColor: Colors.blue,
            borderStyle: BorderStyle.none,
          ),
        ),
      ),
      bottomNavigationBar: Container(height: 80, color: Colors.pink),
      drawer: Container(
        width: 300,
        color: Colors.blue,
      ),
      //创建滑动页面并且和 TabPageSelector 关联
      body: TabBarView(
        controller: controller,
        children: const [Text("页面1"), Text("页面2"), Text("页面3"), Text("页面4")],
      ),
    );
  }
}


class SelectorNotifier extends ChangeNotifier {
  int curIndex = 0;

  void setCurIndex(int curIndex) {
    this.curIndex = curIndex;
    notifyListeners();
  }
}
