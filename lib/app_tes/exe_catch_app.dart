import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/comm_text_widget.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

import '../util/Log.dart';

String summary = '''
异常捕获测试...
''';

void collectLog(String line) {
  Log.d("====collectLog========");
}

void reportErrorAndLog(FlutterErrorDetails details) {
  Log.d("====reportErrorAndLog========");
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  Log.d("====makeDetails========");
  return FlutterErrorDetails(exception: obj, stack: stack);
}

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    reportErrorAndLog(details);
  };

  runZonedGuarded((){}, (Object obj, StackTrace stack) {
    var details = makeDetails(obj, stack);
    reportErrorAndLog(details);
  }, zoneSpecification: ZoneSpecification(
    print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
      collectLog(line); // 收集日志
    },
  ));

  startRunApp();
}

void startRunApp() {
  runApp(const MaterialApp(
    title: "ViewPager Sample",
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

class _State extends State with SingleTickerProviderStateMixin {
  late TabController controller = TabController(length: 4, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("exe catch test"),
      ),
      body: ListView(
        children: [
          CommButton(
              text: "print",
              onPressed: () {
                print("=======print===========");
                Toast.show('print');
              }),
          CommButton(
              text: "debugPrint",
              onPressed: () {
                debugPrint("=======debugPrint===========");
                Toast.show('debugPrint');
              }),
          CommButton(
              text: "Log.d",
              onPressed: () {
                Log.d("=======Log.d===========");
                Toast.show('Log.d');
              }),
          CommButton(
              text: "Log.e",
              onPressed: () {
                Log.e("=======Log.e===========");
                Toast.show('Log.e');
              }),
        ],
      ),
    );
  }
}
