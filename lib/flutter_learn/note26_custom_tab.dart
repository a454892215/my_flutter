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

  Widget _buildCommonTab() {
    List<dynamic> tabList = [];
    for (int i = 0; i < 12; i++) {
      tabList.add("Tab-$i");
    }
    double commTabWidth = 300;
    double commTabHeight = 50;
    return Center(
      child: Container(
        width: commTabWidth,
        height: commTabHeight,
        color: Colors.blue,
        child: CommonTab(
          tabList: tabList,
          width: commTabWidth,
          height: commTabHeight, onItemSelected: (int pos) {  },
        ),
      ),
    );
  }
}
