import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

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
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: names.length,
            itemBuilder: (BuildContext context, int index) {
              //Log.d("itemBuilder: $index");
              return RouterButton(params: names[index]);
            },
          )),
    );
  }

  static List<List<String>> names = pageNameList();

  static List<List<String>> pageNameList() {
    return const [
      ["/TabIndicatorSamplePage", "去-TabIndicatorSamplePage-页面"],
      ["/ScaffoldSamplePage", "去-ScaffoldSamplePage-页面"],
      ["/ProviderSamplePage", "去-ProviderSamplePage-页面"],
      ["/ButtonSamplePage", "去-ButtonSamplePage-页面"],
      ["/TextSamplePage", "去-TextSamplePage-页面"],
      ["/TextFieldSamplePage", "去-TextFieldSamplePage-页面"],
      ["/CheckboxSamplePage", "去-CheckboxSamplePage-页面"],
      ["/FormSamplePage", "去-FormSamplePage-页面"],
      ["/StackAndWrapSamplePage", "去-StackAndWrapSamplePage-页面"],
      ["/ImageSamplePage", "去-ImageSamplePage-页面"],
      ["/ContainerSamplePage", "去-ContainerSamplePage-页面"],
      ["/LinearLayoutSamplePage", "去-LinearLayoutSamplePage-页面"],
      ["/SingleChildScrollViewSamplePage", "去-SingleChildScrollViewSamplePage-页面"],
      ["/NestedScrollViewSamplePage", "去-嵌套滚动页面1-页面"],
      ["/NestedScrollViewSamplePage2", "去-嵌套滚动页面2-页面"],
      ["/NestedScrollViewSamplePage3", "去-嵌套滚动页面3-页面"],
      ["/CustomScrollViewSamplePage", "去-CustomScrollViewSamplePage-页面"],
      ["/ListViewSamplePage", "去-ListViewSamplePage-页面"],
      ["/GridViewSamplePage", "去-GridViewSamplePage-页面"],
      ["/SmartRefreshSamplePage", "去-SmartRefreshSamplePage-页面"],
      ["/AnimationSamplePage", "去-AnimationSamplePage-页面"],
      ["/TweenAnimationBuilderTestPage", "去-TweenAnimationBuilderTestPage-页面"],
      ["/HeroSample", "去-HeroSample-页面"],
      ["/BackdropFilterPage", "去-BackdropFilterPage-页面"],
      ["/WillPopScopeSamplePage", "去-WillPopScopeSamplePage-页面"],
      ["/DateRangePickerPage", "去-DateRangePickerPage-页面"],
      ["/DioHttpSamplePage", "去-DioHttpSamplePage-页面"],
      ["/SharedPreferencesSamplePage", "去-SharedPreferencesSamplePage-页面"],
      ["/GetXSamplePage", "去-GetXSamplePage-页面"],
      ["/CustomTabSamplePage", "去-CustomTabSamplePage-页面"],
      ["/LogTestSamplePage", "去-LogTestSamplePage-页面"],
      ["/DialogSamplePage", "去-DialogSamplePage-页面"],
      ["/ScrollRadioGroupPage", "去-ScrollRadioGroupPage-页面"],
      ["/IndicatorTabGroupPage", "去-IndicatorTabGroupPage-页面"],
      ["/ListViewStateSaveTestPage", "去-ListViewStateSaveTestPage-页面"],
      ["/ScreenAdapterTestPage", "去-ScreenAdapterTestPage-页面"],
      ["/WidgetsBindingObserverTestPage", "去-WidgetsBindingObserverTestPage-页面"],
      ["/RouteAwareTestPage", "去-RouteAwareTestPage-页面"],
      ["/ExceptionTestPage", "去-ExceptionTestPage-页面"],
      ["/CupertinoPickerTestPage", "去-CupertinoPickerTestPage-页面"],
      ["/AsyncTestPage", "去-AsyncTestPage-页面"],
      ["/page999", "去404页面"],
    ];
  }

}
