import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/my_checkbox.dart';
import 'package:provider/provider.dart';

/// 官方提供的 Checkbox， Radio， Switch 等控件不能完全灵活的自定义宽高，相对位置等，后期可能都需要自定义...
/// 复选框 Checkbox, 用法示例
/// 复选框 CheckboxListTile, 用法示例
/// 单选框 Radio, 用法示例
/// 开关 Switch, 用法示例
/// 开关 SwitchListTile, 用法示例
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
            buildSizedBox4(),
            buildSizedBox5(),
            buildSizedBox6(),
          ],
        ),
      ),
    );
  }

  /// 1. 复选框 Checkbox, 用法示例
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

  /// 2. 复选框 Checkbox, 用法示例
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

  /// 3. 自定义复选框 MyCheckBox, 用法示例
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

  /// 4.单选框 Radio, 用法示例 : Radio的groupValue=value表示选中， 一般value作为Radio的Id写死，动态修改groupValue的值来选中目标Radio
  SizedBox buildSizedBox4() {
    /// 如果SizedBox不设置width, Container默认匹配父窗口大小 如果不设置 height, Container默认包过内容大小
    return SizedBox(
      /// 如果是Container 有color 后，内部的InkWell 点击也没有水波纹效果了,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: 160,
        child: Ink(
          color: Colors.grey,
          padding: const EdgeInsets.all(0),
          child: Consumer<_MyValuesNotifier>(builder: (context, notifier, child) {
            return Row(
              children: [
                Radio(
                    value: 0,
                    groupValue: notifier.intRadioValue,
                    activeColor: Colors.green,
                    onChanged: (int? value) => notifier.setIntRadioValue(value ?? 0)),
                Radio(
                    value: 1,
                    groupValue: notifier.intRadioValue,
                    onChanged: (int? value) => notifier.setIntRadioValue(value ?? 0)),
                Radio(
                    value: 2,
                    groupValue: notifier.intRadioValue,
                    onChanged: (int? value) => notifier.setIntRadioValue(value ?? 0)),
              ],
            );
          }),
        ),
      ),
    );
  }
}

/// 2. Switch, 用法示例: Switch的value属性为true表示打，false表示关闭
///    Switch 没有提供api Track Thumb的大小？？？
SizedBox buildSizedBox5() {
  return SizedBox(
    child: Container(
      height: 80,
      width: 180,
      color: Colors.greenAccent,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(0),
      child: Consumer<_MyValuesNotifier>(builder: (context, _MyValuesNotifier notifier, child) {
        return Switch(
          value: notifier.switchEnable,
          // 打开时候 开关样式
          activeColor: Colors.blue,
          activeTrackColor: Colors.white,
          // activeThumbImage: ,
          // 关闭时候开关样式
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: const Color.fromARGB(222, 175, 175, 175),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (bool value) {
            notifier.setSwitchEnable(value);
          },
        );
      }),
    ),
  );
}

/// 2. SwitchListTile, 用法示例: Switch的value属性为true表示打，false表示关闭
///    SwitchListTile 没有提供api Track Thumb的大小？？？
SizedBox buildSizedBox6() {
  return SizedBox(
    child: Container(
      height: 80,
      width: 280,
      color: Colors.greenAccent,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(0),
      child: Consumer<_MyValuesNotifier>(builder: (context, _MyValuesNotifier notifier, child) {
        return SwitchListTile(
          value: notifier.switchListTileEnable,
          // 打开时候 开关样式
          activeColor: Colors.blue,
          activeTrackColor: Colors.white,
          // activeThumbImage: ,
          // 关闭时候开关样式
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: const Color.fromARGB(222, 175, 175, 175),
          title: const Text("我是一级标题"),
          subtitle: const Text("我是2级标题..."),
          onChanged: (bool value) {
            notifier.setSwitchListTileEnable(value);
          },
        );
      }),
    ),
  );
}

class _MyValuesNotifier extends ChangeNotifier {
  int intValue = 0;
  int intRadioValue = 0;
  bool boolValue = false;
  bool boolValue2 = false;
  bool switchEnable = false;
  bool switchListTileEnable = false;

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

  void setIntRadioValue(int value) {
    intRadioValue = value;
    notifyListeners();
  }

  void setSwitchEnable(bool value) {
    switchEnable = value;
    notifyListeners();
  }

  void setSwitchListTileEnable(bool value) {
    switchListTileEnable = value;
    notifyListeners();
  }
}
