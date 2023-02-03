import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

import '../flutter_learn/note36_cupertinoPicker.dart';
import '../flutter_learn/note37_async_test.dart';
import '../my_widgets/comm_widgets.dart';

///Navigator.of(context).pushNamed("/page2"); 这种方式跳转页面是整个页面的跳转
/// 1. StatelessWidget 无动态变化属性的页面
/// 2. StatefulWidget 动态变化属性的页面
class SystemApiSampleListPage extends StatefulWidget {
  const SystemApiSampleListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return Page1State();
  }
}

class Page1State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("系统API用例")),
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
            children: routerButtonList1() + getList2(),
          )),
    );
  }

  List<Widget> routerButtonList1() {
    return const <Widget>[
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
      // RouterButton(params: ["/RefreshSamplePage", "去-RefreshSamplePage-页面"]),
      RouterButton(params: ["/SmartRefreshSamplePage", "去-SmartRefreshSamplePage-页面"]),
      RouterButton(params: ["/AnimationSamplePage", "去-AnimationSamplePage-页面"]),
      RouterButton(params: ["/TweenAnimationBuilderTestPage", "去-TweenAnimationBuilderTestPage-页面"]),
      RouterButton(params: ["/HeroSample", "去-HeroSample-页面"]),
      RouterButton(params: ["/BackdropFilterPage", "去-BackdropFilterPage-页面"]),
      RouterButton(params: ["/WillPopScopeSamplePage", "去-WillPopScopeSamplePage-页面"]),
      RouterButton(params: ["/DateRangePickerPage", "去-DateRangePickerPage-页面"]),
      RouterButton(params: ["/DioHttpSamplePage", "去-DioHttpSamplePage-页面"]),
      RouterButton(params: ["/SharedPreferencesSamplePage", "去-SharedPreferencesSamplePage-页面"]),
      RouterButton(params: ["/GetXSamplePage", "去-GetXSamplePage-页面"]),
      RouterButton(params: ["/CustomTabSamplePage", "去-CustomTabSamplePage-页面"]),
      RouterButton(params: ["/LogTestSamplePage", "去-LogTestSamplePage-页面"]),
      RouterButton(params: ["/DialogSamplePage", "去-DialogSamplePage-页面"]),
      RouterButton(params: ["/ScrollRadioGroupPage", "去-ScrollRadioGroupPage-页面"]),
      RouterButton(params: ["/IndicatorTabGroupPage", "去-IndicatorTabGroupPage-页面"]),
      RouterButton(params: ["/ListViewStateSaveTestPage", "去-ListViewStateSaveTestPage-页面"]),
      RouterButton(params: ["/ScreenAdapterTestPage", "去-ScreenAdapterTestPage-页面"]),
      RouterButton(params: ["/WidgetsBindingObserverTestPage", "去-WidgetsBindingObserverTestPage-页面"]),
      RouterButton(params: ["/RouteAwareTestPage", "去-RouteAwareTestPage-页面"]),
      RouterButton(params: ["/ExceptionTestPage", "去-ExceptionTestPage-页面"]),
      RouterButton(params: ["/page999", "去404页面"]),
    ];
  }

  List<Widget> getList2() {
    return [
      _buildRouterButton(const CupertinoPickerTestPage(), "CupertinoPicker-用例"),
      _buildRouterButton(const AsyncTestPage(), "flutter 异步测试-用例"),
    ];
  }

  CupertinoButton _buildRouterButton(Widget tar, String title) {
    return CupertinoButton(onPressed: () => Get.to(() => tar), color: Colors.grey, padding: const EdgeInsets.all(0), child: Text(title));
  }
}
