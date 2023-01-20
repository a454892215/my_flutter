import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/web_parser_controller.dart';

void main() {
  runApp(MaterialApp(
    title: "MaterialApp",
    home: WebParserPage(),
  ));
}

class WebParserPage extends StatelessWidget {
  WebParserPage({super.key});

  final WebParserController controller = Get.put(WebParserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            height: 50,
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text("WebParserPage"),
          ),
        ],
      )),
    );
  }
}
