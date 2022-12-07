import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/scroll_radio_group.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: ScrollRadioGroupPage(),
  ));
}

class ScrollRadioGroupPage extends StatefulWidget {
  const ScrollRadioGroupPage({super.key});

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
        title: const Text("ScrollRadioGroup-Test"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            const SizedBox(width: 20, height: 20),
            getScrollRadioGroup(),
          ],
        ),
      ),
    );
  }

  Widget getScrollRadioGroup() {
    List<String> list = List.generate(8, (index) => index.toString());
    double itemWidth = 60;
    return ScrollRadioGroup(
        size: list.length,
        itemWidth: itemWidth,
        itemBuilder: (BuildContext context, int index, int selectedPos) {
          bool isSelect = index == selectedPos;
          return Center(
            child: Container(
              color: Colors.green,
              width: itemWidth,
              height: 40,
              child: Center(
                child: Text(
                  list[index],
                  style: TextStyle(color: Color(isSelect ? 0xffffffff : 0xffcccccc)),
                ),
              ),
            ),
          );
        },
        width: 260,
        height: 60,
        itemMargin: 10,
        bgColor: Colors.yellow,
        onSelectChanged: (pos) {});
  }
}
