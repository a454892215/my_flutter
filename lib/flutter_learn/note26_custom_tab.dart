import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: CustomTabSamplePage(),
  ));
}

class CustomTabSamplePage extends StatefulWidget {
  const CustomTabSamplePage({super.key});

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
        title: const Text("CustomTab-Test"),
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          //  alignment: Alignment.center,
          children: const [

          ],
        ),
      ),
    );
  }
}


