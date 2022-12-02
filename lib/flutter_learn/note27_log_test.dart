import 'package:flutter/material.dart';
import '../util/Log.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: LogTestSamplePage(),
  ));
}

class LogTestSamplePage extends StatefulWidget {
  const LogTestSamplePage({super.key});

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
        title: const Text("Log-Test"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            ElevatedButton(
                child: const Text("print"),
                onPressed: () {
                  print("=======print===========");
                }),
            ElevatedButton(
                child: const Text("debugPrint"),
                onPressed: () {
                  debugPrint("=======debugPrint===========");
                }),
            ElevatedButton(
                child: const Text("Log.d"),
                onPressed: () {
                  Log.d("=======Log.d===========");
                }),
            ElevatedButton(
                child: const Text("Log.e"),
                onPressed: () {
                  Log.e("=======Log.e===========");
                }),
          ],
        ),
      ),
    );
  }
}
