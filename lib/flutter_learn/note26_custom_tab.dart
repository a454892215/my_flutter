import 'package:flutter/material.dart';

import '../my_widgets/comm_tab.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: CustomTabSamplePage(),
  ));
}

class CustomTabSamplePage extends StatefulWidget {
  const CustomTabSamplePage({super.key});

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
        title: const Text("CustomTab-Test"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          //  alignment: Alignment.center,
          children: [
            _buildCommonTab(),
          ],
        ),
      ),
    );
  }

  /// CommonTab
  Widget _buildCommonTab() {
    List<dynamic> tabList = [];
    for (int i = 0; i < 13; i++) {
      tabList.add("Tab-$i");
    }
    int maxShowingTabCount = 5;
    double leftRightPadding = 10;
    double tabWidth = (300 - leftRightPadding * 2) / maxShowingTabCount;
    int realShowingTabCount = tabList.length > maxShowingTabCount ? maxShowingTabCount : tabList.length;
    double commTabWidth = tabWidth * realShowingTabCount;
    double commTabHeight = 50;
    return Center(
      child: Container(
        width: double.infinity,
        height: commTabHeight,
        padding: EdgeInsets.only(left: leftRightPadding, right: leftRightPadding),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffdbdbdd), width: 2))),
        child: CommonTab(
          tabList: tabList,
          onItemSelected: (pos) {
          },
          width: commTabWidth,
          height: commTabHeight,
          tabWidth: tabWidth,
          fontColor: const Color(0xffbbbbbb),
          selectedFontColor: const Color(0xff0185cb),
          indicatorColor: const Color(0xff0084cb),
          indicatorWidth: tabWidth,
          indicatorHeight: 2,
          fontSize: 14,
          selectedFontSize: 15,
          indicatorAnimEnable: true,
          bgColor: Colors.grey,
        ),
      ),
    );
  }
}
