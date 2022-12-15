import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/scroll_radio_group.dart';

import '../my_widgets/indicator_tab_group.dart';

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
          IndicatorTabGroup(
            size: 12,
            itemBuilder: _buildIndicatorTabItemBuilder,
            width: 320,
            height: 60,
            itemWidth: itemWidth,
            onSelectChanged: (pos) {},
            bgColor: Colors.red,
            alignment: Alignment.center,
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
}
