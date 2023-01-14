import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_flutter_lib_3/env.dart';
import '../lib_samples/note01_picker.dart';
import '../lib_samples/note02_screenshot_event.dart';
import '../my_widgets/comm_widgets.dart';
import '../util/Log.dart';

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
  void initState() {
    super.initState();
    Log.d(EnvironmentConfig.getAppInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("第三方库API用例"),
        ),
        backgroundColor: const Color.fromARGB(222, 231, 231, 231),
        body: Material(
          child: Align(
              alignment: Alignment.topCenter,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  MaterialButton(child: const Text("picker库用例"), onPressed: () => Get.to(() => const PickerSamplePage())),
                  MaterialButton(child: const Text("ScreenShotEvent用例"), onPressed: () => Get.to(() => const ScreenShotEventSamplePage())),
                ],
              )),
        ));
  }
}
