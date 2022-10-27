import 'package:flutter/material.dart';
String summary = '''
ProgressIndicator:
1. CircularProgressIndicator 
2. LinearProgressIndicator 
''';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text("ProgressIndicator")),
      body: const _TestWidget(),
    ),
  ));
}

class _TestWidget extends StatefulWidget {
  const _TestWidget();

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: const [
              CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.blue,
              ),
              Padding(padding: EdgeInsets.all(12)),
              LinearProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.blue,
              )
            ],
          ));
    });
  }
}
