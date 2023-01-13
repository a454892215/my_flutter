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
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: MyCupertinoPicker(
              diameterRatio: 32,
              backgroundColor: Colors.transparent,
              onSelectedItemChanged: (int value) {},
              itemExtent: 50,
              // item高度
              useMagnifier: true,
              magnification: 1.1,
              squeeze: 1,
              // 两侧缩小比： squeeze
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
          ),
        ],
      ),
    ));
  }

  static Future<void> exe() async {}
}
