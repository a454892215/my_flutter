import 'package:flutter/material.dart';

String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: _Page(),
  ));
}

class _Page extends StatefulWidget {
  const _Page();

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
        title: const Text("Sample"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text("按钮"),
      ),
      body: Container(
        color: Colors.grey,
        /// 1. 和 Row 的crossAxisAlignment: CrossAxisAlignment.stretch, 配合使用约束拉升高度
        /// 2.  如果没有IntrinsicHeight直接拉升到父控件高度，有则拉升到最高子控件高度
        child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 120, height: 50, color: Colors.blue),
                Container(width: 120, height: 80, color: Colors.red),
                Container(width: 120, height: 120, color: Colors.orange),
              ],
            )),
      ),
    );
  }
}
