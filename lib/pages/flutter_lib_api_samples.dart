import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_lib_3/env.dart';
import '../lib_samples/note01_picker.dart';
import '../lib_samples/note02_screenshot_event.dart';
import '../lib_samples/note03_web_parser.dart';
import '../lib_samples/note04_refresher_normal.dart';
import '../lib_samples/note05_refresher_chatroom.dart';
import '../lib_samples/note06_render_box1.dart';
import '../lib_samples/note07_render_box2.dart';
import '../lib_samples/note08_reskin.dart';
import '../lib_samples/note09_InheritedWidget.dart';
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
    EnvironmentConfig.getAppInfo().then((value) => Log.i(value));
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
                  MaterialButton(child: const Text("WebParserPage"), onPressed: () => Get.to(() => WebParserPage())),
                  MaterialButton(child: const Text("refresher-正常模式"), onPressed: () => Get.to(() => const RefresherNormalSamplePage())),
                  MaterialButton(child: const Text("refresher-聊天室模式"), onPressed: () => Get.to(() => const RefresherChatRoomPage())),
                  MaterialButton(child: const Text("RenderBoxPage1"), onPressed: () => Get.to(() => const RenderBoxPage1())),
                  MaterialButton(child: const Text("RenderBoxPage1"), onPressed: () => Get.to(() => const RenderBoxPage1())),
                  MaterialButton(child: const Text("换肤"), onPressed: () => Get.to(() => const ChangeSkinPage())),
                  MaterialButton(child: const Text("InheritedWidgetPage"), onPressed: () => Get.to(() => const InheritedWidgetPage())),
                ],
              )),
        ));
  }
}
