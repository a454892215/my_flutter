import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: LoadingWidget(),
    ),
  ));
}

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
