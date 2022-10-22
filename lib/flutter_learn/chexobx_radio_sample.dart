import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 复选框，单选框用法示例
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
            SizedBox(
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
            ),

          ],
        ),
      ),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {
  int intValue = 0;
  bool boolValue = false;

  void setIntValue(int value) {
    intValue = value;
    notifyListeners();
  }

  void setBoolValue(bool value) {
    boolValue = value;
    notifyListeners();
  }
}
