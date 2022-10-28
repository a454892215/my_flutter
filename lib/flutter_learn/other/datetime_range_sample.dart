import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

import '../../util/Log.dart';

String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    /// 国际化配置=== start=====
    locale: Locale("zh", "CH"),
    supportedLocales: [Locale("zh", "CH")],
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],

    /// 国际化配置=== end=====
    title: "MaterialApp",
    home: _Page(),
  ));
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Toast.show("FloatingActionButton");
          showDateTimeSelect();
        },
        child: const Text("按钮"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(width: 120, height: 120, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  /// 异步函数，不确定什么时候返回，而且不能阻止线程...
  void showDateTimeSelect() async {
    var ret = await showDateRangePicker(
      locale: const Locale("zh", "CH"),
      context: context,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2022, 1),
    );
    Toast.show("$ret");
    Log.d("ret:$ret");
  }
}
