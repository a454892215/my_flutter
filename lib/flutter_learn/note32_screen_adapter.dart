import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/dimen.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: ScreenAdapterTestPage(),
  ));
}

class ScreenAdapterTestPage extends StatefulWidget {
  const ScreenAdapterTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  final double itemWidth = 80;
  final ValueNotifier<double> heightNotifier = ValueNotifier<double>(5.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xffff9ef0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            buildLayer1View(),

            // Container(width: double.infinity, height: double.infinity, color: const Color(0x88000000)),
          ],
        ),
      ),
    );
  }

  Widget buildLayer1View() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(title: const Text("屏幕适配验证")),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(10, (index) {
            var width = ((index + 1.0) / 10.0);
            return Container(
              alignment: Alignment.center,
              width: width.sw,
              height: 20,
              color: index % 2 == 0 ? Colors.blue : Colors.yellow,
              child: Text("$width" 'w', style: const TextStyle(color: Colors.white)),
            );
          }),
        ),
      ],
    );
  }
}
