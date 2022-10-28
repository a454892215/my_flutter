import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

import '../../util/Log.dart';

String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    /// 国际化配置=== start=====
    locale: Locale("zh", "CH"),
    supportedLocales: [Locale("zh", "CH")],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,

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
    DateTime now = DateTime.now();
    var start = DateTime(2020, 10);
    var end = DateTime(now.year, now.month);
    DateTimeRange? selected = await showDateRangePicker(
      //    locale: const Locale("zh", "CH"),
      context: context,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(now.year, now.month),
      // 设置默认选中是时间范围
      initialDateRange: DateTimeRange(start: start, end: end),
      saveText: "保存",
      cancelText: "取消",
    );
    if (selected != null) {
      var selectedStart = selected.start;
      var selectedEnd = selected.end;
      Log.d("selectedStart:$selectedStart  selectedEnd:$selectedEnd");
    }
  }
}
