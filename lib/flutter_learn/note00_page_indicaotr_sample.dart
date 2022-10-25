import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TabIndicatorSamplePage",
      home: TabIndicatorSamplePage(),
    );
  }
}

class TabIndicatorSamplePage extends StatefulWidget {
  const TabIndicatorSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainScaffoldPageState();
  }
}

/// SingleTickerProviderStateMixin 只能被State的实现类with
class MainScaffoldPageState extends State with SingleTickerProviderStateMixin {
  late TabController controller;

  //==对象创建后之会被调用一次==
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => SelectorNotifier())],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TabIndicatorSamplePage"),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          bottom: _buildBottomPreferredSize(),
        ),
        bottomSheet: _buildBottomSheet(),
        bottomNavigationBar: Container(height: 80, color: Colors.pink),
        /// 1. 创建TabBarView 滑动页面并且和 TabPageSelector, TabBar 关联
        body: TabBarView(
          controller: controller,
          children: const [Text("页面1"), Text("页面2"), Text("页面3"), Text("页面4")],
        ),
      ),
    );
  }

  Container _buildBottomSheet() {
    return Container(
      height: 30,
      color: Colors.white,
      child: Center(
        /// 2，设置 圆点 indicators
        child: TabPageSelector(
          controller: controller,
          indicatorSize: 7,
          color: Colors.grey,
          selectedColor: Colors.blue,
          borderStyle: BorderStyle.none,
        ),
      ),
    );
  }

  PreferredSize _buildBottomPreferredSize() {
    const double tabHeight = 42;
    return PreferredSize(
      preferredSize: const Size.fromHeight(tabHeight), // 不占用AppBar的高度，自己扩展出新高度
      child: Container(
        height: tabHeight,
        color: const Color.fromARGB(255, 252, 189, 35),

        /// 3. 设置 文字和和下横条 indicators
        child: TabBar(
          tabs: const [
            Text("tab-1"),
            Text("tab-2"),
            Text("tab-3"),
            Text("tab-4"),
          ],
          controller: controller,
          // indicatorPadding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
          indicatorWeight: 2,
          // indicator线的高度
          // 设置indicator宽度 label：文字等宽， tab：等分宽度
          indicatorSize: TabBarIndicatorSize.tab,
          //选中的样式
          labelStyle: const TextStyle(fontSize: 20, color: Colors.white),
          // 没有选中的样式
          unselectedLabelStyle: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
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
