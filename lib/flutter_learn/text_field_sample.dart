import 'package:flutter/material.dart';


class TextFieldSamplePage extends StatefulWidget {
  const TextFieldSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return TextSamplePageState();
  }
}

class TextSamplePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TextFieldSamplePage")),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              width: 0,
              height: 10,
            ),
            _buildSizedBox1(),
            const SizedBox(
              width: 0,
              height: 10,
            ),

          ],
        ),
      ),
    );
  }

  SizedBox _buildSizedBox1() {
    return SizedBox(
      width: 120,
      height: 80,
      child: Container(
        color: Colors.blueGrey,
      ),
    );
  }
