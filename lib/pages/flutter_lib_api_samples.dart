import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../lib_samples/note01_picker.dart';
import '../my_widgets/comm_widgets.dart';

///Navigator.of(context).pushNamed("/page2"); 这种方式跳转页面是整个页面的跳转

class LibApiSamplesPage extends StatefulWidget {
  const LibApiSamplesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return Page2State();
  }
}

class Page2State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("第三方库API用例"),
        ),
        backgroundColor: const Color.fromARGB(222, 231, 231, 231),
        body: Align(
            alignment: Alignment.topCenter,
            child: ListView(
              shrinkWrap: true,
              children: <CupertinoButton>[
                CupertinoButton(child: const Text("picker库用例"), onPressed: () => Get.to(const PickerSamplePage())),
              ],
            )));
  }
}
