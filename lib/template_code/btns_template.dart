import 'package:flutter/material.dart';

import '../my_widgets/comm_text_widget.dart';

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
        title: const Text("btn_template"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: ListView(
          children: [
            CommButton(onPressed: () {}, text: "CommButton1"),
            CommButton(onPressed: () {}, text: "CommButton2"),
            CommButton(onPressed: () {}, text: "CommButton3"),
            TextButton(onPressed: () {}, child: const Text("TextButton")),
            MaterialButton(onPressed: () {}, child: const Text("MaterialButton")),
            OutlinedButton(onPressed: () {}, child: const Text("OutlinedButton")),
            ElevatedButton(onPressed: () {}, child: const Text("ElevatedButton")),
          ],
        ),
      ),
    );
  }
}
