import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    title: "Comm App Sample",
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
        title: const Text("Comm App Sample"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Toast.show("FloatingActionButton");
        },

        child: const Text("按钮"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(width: 120, height: 120, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
