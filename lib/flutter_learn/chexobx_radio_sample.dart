import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/my_checkbox.dart';
import 'package:provider/provider.dart';

/// 复选框 Checkbox, 用法示例
/// 复选框 CheckboxListTile, 用法示例
class CheckboxSamplePage extends StatefulWidget {
  const CheckboxSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _MyValuesNotifier()),
        //  Provider(create: (context) => SomeOtherClass()),
      ],
      child: buildScaffold(),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: AppBar(title: const Text("复选框单选框示例")),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            buildSizedBox1(),
            //   UIUtil.getEmptyBoxByHeight(10),
            buildSizedBox2(),

            buildSizedBox3(),
          ],
        ),
      ),
    );
  }

  SizedBox buildSizedBox1() {
    return SizedBox(
      width: 200,
      height: 100,
      child: Container(
        color: Colors.grey,
        margin: const EdgeInsets.all(10),
        child: Consumer<_MyValuesNotifier>(builder: (context, _MyValuesNotifier notifier, child) {
          return Checkbox(
            onChanged: (value) {
              notifier.setBoolValue(value ?? false);
            },
            value: notifier.boolValue,
          );
        }),
      ),
    );
  }

  SizedBox buildSizedBox2() {
    return SizedBox(
      /// 如果SizedBox不设置width, Container默认匹配父窗口大小 如果不设置 height, Container默认包过内容大小
      child: Container(
        color: Colors.grey,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(0),
        child: Consumer<_MyValuesNotifier>(builder: (context, _MyValuesNotifier notifier, child) {
          return CheckboxListTile(
            title: const Text("你是一个小娃娃"),
            subtitle: const Text("你是二级标题"),
            secondary: const Icon(Icons.check_circle_sharp),
            onChanged: (value) {
              notifier.setBoolValue2(value ?? false);
            },
            value: notifier.boolValue2,
          );
        }),
      ),
    );
  }

  SizedBox buildSizedBox3() {
    /// 如果SizedBox不设置width, Container默认匹配父窗口大小 如果不设置 height, Container默认包过内容大小
    return SizedBox(
      /// 如果是Container 有color 后，内部的InkWell 点击也没有水波纹效果了,
      child: Ink(
        color: Colors.grey,
        padding: const EdgeInsets.all(0),
        child: const MyCheckBox(title: "Home"),
      ),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {
  int intValue = 0;
  bool boolValue = false;
  bool boolValue2 = false;

  void setIntValue(int value) {
    intValue = value;
    notifyListeners();
  }

  void setBoolValue(bool value) {
    boolValue = value;
    notifyListeners();
  }

  void setBoolValue2(bool value) {
    boolValue2 = value;
    notifyListeners();
  }
}
