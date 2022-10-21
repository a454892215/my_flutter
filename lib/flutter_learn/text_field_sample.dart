import 'package:flutter/material.dart';

class TextFieldSamplePage extends StatefulWidget {
  const TextFieldSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TextSamplePageState();
  }
}

class _TextSamplePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TextFieldSamplePage")),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(children: [
          buildEmptyBox(),
          SizedBox(
            width: 100,
            height: 100,
            child: Container(
              color: Colors.grey,
              child: Column(
                children: [
                  buildEmptyBox(),
                ],
              ),
            ),
          )
        ],),
      ),
    );
  }

  SizedBox buildEmptyBox() {
    return const SizedBox(width: 0, height: 20);
  }
}
