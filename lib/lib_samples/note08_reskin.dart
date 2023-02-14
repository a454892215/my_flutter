import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/lib_samples/skin/skin_manager.dart';

class ChangeSkinPage extends StatefulWidget {
  const ChangeSkinPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("换肤-示例"),
      ),
      body: Align(
        child: Container(
          width: 200,
          height: 200,
          color: skin().bgColor1(),
          child: Text(
            "你好哇",
            style: TextStyle(color: skin().textColor1()),
          ),
        ),
      ),
    );
  }
}
