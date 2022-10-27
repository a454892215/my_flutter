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
      appBar: AppBar(title: const Icon(Icons.home)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Toast.toast("你好啊");
        },
      ),
      // backgroundColor: const Color.fromARGB(255, 103, 204, 248),
      body: Align(
          alignment: Alignment.topCenter,
          child: ListView(
            shrinkWrap: true,
            children: const <RouterButton>[
              RouterButton(params: ["/TabIndicatorSamplePage", "去-TabIndicatorSamplePage-页面"]),
              RouterButton(params: ["/ScaffoldSamplePage", "去-ScaffoldSamplePage-页面"]),
              RouterButton(params: ["/ProviderSamplePage", "去-ProviderSamplePage-页面"]),
              RouterButton(params: ["/ButtonSamplePage", "去-ButtonSamplePage-页面"]),
              RouterButton(params: ["/TextSamplePage", "去-TextSamplePage-页面"]),
              RouterButton(params: ["/TextFieldSamplePage", "去-TextFieldSamplePage-页面"]),
              RouterButton(params: ["/CheckboxSamplePage", "去-CheckboxSamplePage-页面"]),
              RouterButton(params: ["/FormSamplePage", "去-FormSamplePage-页面"]),
              RouterButton(params: ["/StackAndWrapSamplePage", "去-StackAndWrapSamplePage-页面"]),
              RouterButton(params: ["/ImageSamplePage", "去-ImageSamplePage-页面"]),
              RouterButton(params: ["/ContainerSamplePage", "去-ContainerSamplePage-页面"]),
              RouterButton(params: ["/LinearLayoutSamplePage", "去-LinearLayoutSamplePage-页面"]),
              RouterButton(params: ["/SingleChildScrollViewSamplePage", "去-SingleChildScrollViewSamplePage-页面"]),
              RouterButton(params: ["/NestedScrollViewSamplePage", "去-NestedScrollViewSamplePage-页面"]),
              RouterButton(params: ["/NestedScrollViewSamplePage2", "去-NestedScrollViewSamplePage2-页面"]),
              RouterButton(params: ["/CustomScrollViewSamplePage", "去-CustomScrollViewSamplePage-页面"]),
              RouterButton(params: ["/CustomScrollViewSample2Page", "去-CustomScrollViewSample2Page-页面"]),
              RouterButton(params: ["/ListViewSamplePage", "去-ListViewSamplePage-页面"]),
              RouterButton(params: ["/GridViewSamplePage", "去-GridViewSamplePage-页面"]),
              RouterButton(params: ["/RefreshSamplePage", "去-RefreshSamplePage-页面"]),
              RouterButton(params: ["/SmartRefreshSamplePage", "去-SmartRefreshSamplePage-页面"]),
              RouterButton(params: ["/AnimationSamplePage", "去-AnimationSamplePage-页面"]),
              RouterButton(params: ["/HeroSample", "去-HeroSample-页面"]),
              RouterButton(params: ["/BackdropFilterPage", "去-BackdropFilterPage-页面"]),
              RouterButton(params: ["/page999", "去404页面"]),
            ],
          )),
    );
  }
}
