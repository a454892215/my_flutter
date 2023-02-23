import 'package:flutter/material.dart';


class WrapTestPage extends StatefulWidget {
  const WrapTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wrap-示例"),
      ),
      body: Wrap(
        direction: Axis.horizontal,
        children: [
          Container(width: 80, height: 30, color: Colors.green),
          Container(width: 80, height: 30, color: Colors.yellow),
          Container(width: 80, height: 30, color: Colors.blue),
          Container(width: 80, height: 30, color: Colors.green),
          const SizedBox(width: 10),
          Container(width: 80, height: 30, color: Colors.yellow),
          const SizedBox(width: 10),
          Container(width: 80, height: 30, color: Colors.blue),
          const SizedBox(width: 10),
          Container(width: 80, height: 30, color: Colors.green),
          const SizedBox(width: 10),
          Container(width: 80, height: 30, color: Colors.yellow),
          Container(width: 80, height: 40, color: Colors.blue),
          const SizedBox(width: 10),
          Container(width: 80, height: 60, color: Colors.yellow),
          const SizedBox(width: 10),
          Container(width: 80, height: 30, color: Colors.blue),
          const SizedBox(width: 10),
          Container(width: 80, height: 30, color: Colors.green),
          const SizedBox(width: 10),
          Container(width: 80, height: 30, color: Colors.yellow),
          Container(width: 80, height: 30, color: Colors.blue),
          Container(width: 80, height: 30, color: Colors.green),
          const SizedBox(width: 10),
          Container(width: 80, height: 30, color: Colors.yellow),
          Container(width: 80, height: 30, color: Colors.blue),
        ],
      ),
    );
  }
}
