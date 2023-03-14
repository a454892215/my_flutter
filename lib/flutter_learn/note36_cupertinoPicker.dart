import 'package:flutter/material.dart';
import '../my_widgets/my_picker.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: CupertinoPickerTestPage(),
  ));
}

class CupertinoPickerTestPage extends StatefulWidget {
  const CupertinoPickerTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CupertinoPickerTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          Container(
            height: 50,
            color: Colors.yellow,
            child: const Center(
              child: Text("CupertinoPicker-用例"),
            ),
          ),
          buildSample1(),
          buildSample2(),
          buildSample3(),
          buildSample4(),
        ],
      ),
    ));
  }

  Widget buildSample4() {
    return Container(
      height: 150,
      color: Colors.grey,
      child: ListWheelScrollView(
        /// 偏转两侧UI形成的立体效果
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(),
        diameterRatio: 40,
        onSelectedItemChanged: (int value) {},
        itemExtent: 50,
        // item高度
        useMagnifier: false,
        overAndUnderCenterOpacity: 1,

        /// 使用放大 magnification > 1，滚动时候 下面多一根横线
        magnification: 1,

        /// 两侧缩小比： squeeze
        squeeze: 1,
        children: List.generate(
            20,
            (index) => Container(
                  height: 50,
                  alignment: Alignment.center,
                  color: index % 2 == 0 ? Colors.green : Colors.blue,
                  child: Text(
                    "item:$index",
                    style: const TextStyle(fontSize: 14),
                  ),
                )),
      ),
    );
  }

  Widget buildSample3() {
    return Container(
      height: 150,
      color: Colors.grey,
      child: MyCupertinoPicker(
        key: UniqueKey(),

        /// 偏转两侧UI形成的立体效果
        diameterRatio: 4,
        backgroundColor: Colors.transparent,
        onSelectedItemChanged: (int value) {},
        // item高度
        itemExtent: 50,

        useMagnifier: false,
        kOverAndUnderCenterOpacity: 0.4,

        /// 使用放大 magnification > 1，滚动时候 下面多一根横线
        magnification: 1,

        /// 两侧缩小比： squeeze
        squeeze: 1,
        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
          background: Colors.transparent,
        ),
        looping: true,
        children: List.generate(
            20,
            (index) => Container(
                  height: 50,
                  alignment: Alignment.center,
                  color: index % 2 == 0 ? Colors.green : Colors.blue,
                  child: Text(
                    "item:$index",
                    style: const TextStyle(fontSize: 14),
                  ),
                )),
      ),
    );
  }

  Widget buildSample2() {
    return Container(
      height: 150,
      color: Colors.grey,
      child: MyCupertinoPicker(
        key: UniqueKey(),

        /// 偏转两侧UI形成的立体效果
        diameterRatio: 0.57,
        backgroundColor: Colors.transparent,
        onSelectedItemChanged: (int value) {},
        itemExtent: 50,
        // item高度
        useMagnifier: false,

        /// 使用放大 magnification > 1，滚动时候 下面多一根横线
        magnification: 1,

        /// 两侧缩小比： squeeze
        squeeze: 1,
        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
          background: Colors.transparent,
          capEndEdge: false,
          capStartEdge: false,
        ),
        looping: true,
        children: List.generate(
            20,
            (index) => Container(
                  height: 50,
                  alignment: Alignment.center,
                  color: index % 2 == 0 ? Colors.green : Colors.blue,
                  child: Text(
                    "item:$index",
                    style: const TextStyle(fontSize: 14),
                  ),
                )),
      ),
    );
  }
  FixedExtentScrollController controller = FixedExtentScrollController();


  Widget buildSample1() {
    return Container(
      height: 150,
      color: Colors.grey,
      child: MyCupertinoPicker(
        key: UniqueKey(),
        scrollController: controller,
        /// 偏转两侧UI形成的立体效果
        diameterRatio: 50,
        backgroundColor: Colors.transparent,
        onSelectedItemChanged: (int value) {},
        itemExtent: 50,
        // item高度
        useMagnifier: false,

        /// 使用放大 magnification > 1，滚动时候 下面多一根横线
        magnification: 1,

        /// 两侧缩小比： squeeze
        squeeze: 1,
        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
          background: Colors.transparent,
          capEndEdge: false,
          capStartEdge: false,
        ),
        looping: false,
        children: List.generate(
            20,
            (index) => GestureDetector(
                  onTap: () {
                    controller.animateToItem(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    color: index % 2 == 0 ? Colors.green : Colors.blue,
                    child: Text(
                      "item:$index",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                )),
      ),
    );
  }

  static Future<void> exe() async {}
}
