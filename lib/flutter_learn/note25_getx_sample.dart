import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';

import '../my_widgets/comm_text_widget.dart';

String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: GetXSamplePage(),
  ));
}

class GetXSamplePage extends StatefulWidget {
  const GetXSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  var count = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetXSamplePage"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          //  alignment: Alignment.center,
          children: [
            Obx(() => CommButton(
                onPressed: () {
                  count++;
                },
                text: "按钮： $count")),
          ],
        ),
      ),
    );
  }
}
