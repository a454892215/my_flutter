import 'package:flutter/material.dart';

import '../my_widgets/horizontal_tab_group.dart';
import '../my_widgets/vetival_tab_group.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: IndicatorTabGroupPage(),
  ));
}

class IndicatorTabGroupPage extends StatefulWidget {
  const IndicatorTabGroupPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  final double itemWidth = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IndicatorTabGroupPage-Test"),
      ),
      body: Column(
        children: [
          HorizontalTabGroup(
            size: 12,
            itemBuilder: _buildIndicatorTabItemBuilder,
            width: 320,
            height: 60,
            itemWidth: itemWidth,
            itemMargin: 10,
            onSelectChanged: (pos) {},
            bgColor: Colors.orange,
            alignment: Alignment.center,
            indicatorAttr: IndicatorAttr(color: Colors.red, height: 3, horPadding: 19),
            controller: IndicatorTabController(),
          ),
          VerticalTabGroup(
            size: 12,
            itemBuilder: _buildIndicatorTabItemBuilder2,
            width: 120,
            height: 320,
            itemHeight: 70,
            itemMargin: 10,
            onSelectChanged: (pos) {},
            bgColor: Colors.orange,
            alignment: Alignment.center,
            controller: VerticalTabController(),
          ),
        ],


      ),
    );
  }

  Widget _buildIndicatorTabItemBuilder(BuildContext context, int index, int selectedPos) {
    bool selected = index == selectedPos;
    Color color = selected ? Colors.white : Colors.black;
    return Container(
      width: itemWidth,
      color: selected ? Colors.blue : Colors.grey,
      child: Center(
        child: Text(
          "tab-$index",
          style: TextStyle(color: color),
        ),
      ),
    );
  }

  Widget _buildIndicatorTabItemBuilder2(BuildContext context, int index, int selectedPos) {
    bool selected = index == selectedPos;
    Color color = selected ? Colors.white : Colors.black;
    return Container(
      height:70 ,
      color: selected ? Colors.blue : Colors.grey,
      child: Center(
        child: Text(
          "tab-$index",
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}
