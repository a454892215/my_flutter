import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/loading.dart';

void main() {
  runApp(const MaterialApp(
    home: BadgePage(),
  ));
}

class BadgePage extends StatefulWidget {
  const BadgePage({super.key});

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
        title: const Text("高斯模糊背景"),
      ),
    );
  }
}
