import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: LayoutBuilderTestWidget(),
    ),
  ));
}

class LayoutBuilderTestWidget extends StatefulWidget {
  const LayoutBuilderTestWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: Colors.blue,
        width: constraints.maxWidth / 2,
        height: constraints.maxHeight / 2,
      );
    });
  }
}
