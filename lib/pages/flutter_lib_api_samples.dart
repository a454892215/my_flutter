import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_lib_3/env.dart';
import '../flutter_learn/note14_nested_scroll_sample2_2.dart';
import '../flutter_learn/note14_nested_scroll_sample2_3.dart';
import '../lib_samples/index_stack.dart';
import '../lib_samples/loop_scroll.dart';
import '../lib_samples/note01_picker.dart';
import '../lib_samples/note02_screenshot_event.dart';
import '../lib_samples/note03_web_parser.dart';
import '../lib_samples/note04_refresher_normal.dart';
import '../lib_samples/note05_refresher_chatroom.dart';
import '../lib_samples/note06_render_box1.dart';
import '../lib_samples/note08_reskin.dart';
import '../lib_samples/note09_InheritedWidget.dart';
import '../lib_samples/note10_wrap.dart';
import '../lib_samples/note11_2_pic_measure.dart';
import '../lib_samples/note11_pic_measure.dart';
import '../lib_samples/note12_text_measure.dart';
import '../lib_samples/note13_obx_sc.dart';
import '../lib_samples/note14_scroll_state_listener.dart';
import '../lib_samples/note15_chat_room.dart';
import '../lib_samples/note16_chat_room.dart';
import '../lib_samples/note17_chat_room.dart';
import '../lib_samples/note18_google_list_view.dart';
import '../lib_samples/sticky_header_test.dart';
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
                  MaterialButton(child: const Text("WrapTestPage"), onPressed: () => Get.to(() => const WrapTestPage())),
                  MaterialButton(child: const Text("EasyRefreshSamplePage-异常嵌套头模式"), onPressed: () => Get.to(() => const EasyRefreshSamplePage())),
                  MaterialButton(child: const Text("EasyRefreshSample2Page-正常嵌套头模式"), onPressed: () => Get.to(() => const EasyRefreshSample2Page())),
                  MaterialButton(child: const Text("图片大小测量-验证"), onPressed: () => Get.to(() =>  const ChatPage())),
                  MaterialButton(child: const Text("带有图片的widget大小测量-验证2"), onPressed: () => Get.to(() =>  const WidgetMeasurePage())),
                  MaterialButton(child: const Text("文字大小测量-验证"), onPressed: () => Get.to(() =>  const TextMeasureWidget())),
                  MaterialButton(child: const Text("Obx嵌套-验证"), onPressed: () => Get.to(() =>  const ObxNestTestWidget())),
                  MaterialButton(child: const Text("滚动状态监听-验证"), onPressed: () => Get.to(() =>  const ScrollStateListenerTestWidget())),
                  MaterialButton(child: const Text("聊天室1-测试"), onPressed: () => Get.to(() =>  const ChatRoomTest1Widget())),
                  MaterialButton(child: const Text("聊天室2-测试"), onPressed: () => Get.to(() =>  const ChatRoomTest2Widget())),
                  MaterialButton(child: const Text("聊天室3-测试"), onPressed: () => Get.to(() =>  const ChatRoomTest3Widget())),
                  MaterialButton(child: const Text("ScrollablePositionedList-下拉刷新和加载更多"), onPressed: () => Get.to(() =>  const ScrollablePositionedListTest())),
                  MaterialButton(child: const Text("flutter_sticky_header"), onPressed: () => Get.to(() =>  const StickerHeaderWidget())),
                  MaterialButton(child: const Text("左右循环组件"), onPressed: () => Get.to(() =>  const LoopScrollTestWidget())),
                  MaterialButton(child: const Text("IndexedStack组件"), onPressed: () => Get.to(() =>  const IndexedStackTestWidget())),
                ],
              )),
        ));
  }
}
