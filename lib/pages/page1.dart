import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

import '../my_widgets/comm_widgets.dart';

///Navigator.of(context).pushNamed("/page2"); 这种方式跳转页面是整个页面的跳转
/// 1. StatelessWidget 无动态变化属性的页面
/// 2. StatefulWidget 动态变化属性的页面
class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<StatefulWidget> createState() {
    return Page1State();
  }
}

class Page1State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.home)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Toast.toast("你好啊");
        },
      ),
      // backgroundColor: const Color.fromARGB(255, 103, 204, 248),
      body: Center(
          child: Column(
        children: const <RouterButton>[
          RouterButton(params: ["/page1", "去首页"]),
          RouterButton(params: ["/page2", "去页面2"]),
          RouterButton(params: ["/page3", "去页面3"]),
          RouterButton(params: ["/ButtonSamplePage", "按钮示例页面"]),
          RouterButton(params: ["/TabIndicatorSamplePage", "去-TabIndicatorSamplePage-页面"]),
          RouterButton(params: ["/ScaffoldSamplePage", "去-ScaffoldSamplePage-页面"]),
          RouterButton(params: ["/ProviderSamplePage", "去-ProviderSamplePage-页面"]),
          RouterButton(params: ["/TextSamplePage", "去-TextSamplePage-页面"]),
          RouterButton(params: ["/TextFieldSamplePage", "去-TextFieldSamplePage-页面"]),
          RouterButton(params: ["/CheckboxSamplePage", "去-CheckboxSamplePage-页面"]),
          RouterButton(params: ["/FormSamplePage", "去-FormSamplePage-页面"]),
          RouterButton(params: ["/ContainerSamplePage", "去-ContainerSamplePage-页面"]),
          RouterButton(params: ["/LinearLayoutSamplePage", "去-LinearLayoutSamplePage-页面"]),
          RouterButton(params: ["/page999", "去404页面"]),
        ],
      )),
    );
  }
}
