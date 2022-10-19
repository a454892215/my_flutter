import 'package:flutter/material.dart';

class ErrPage extends StatefulWidget {
  const ErrPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("404找不到"),
      ),
      body: const Center(
        child: Text("404找不到", style: TextStyle(color: Colors.red),),
      ),
    );
  }
}
