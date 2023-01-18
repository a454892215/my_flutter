import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/execute_timer.dart';

import '../util/Log.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: AsyncTestPage(),
  ));
}
/// debounce防抖  节流（throttle）
class AsyncTestPage extends StatefulWidget {
  const AsyncTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

Future<int> computeTask(String str) async {
  Log.d("启动任务...");
  for (int i = 0; i < 10000000; i++) {
    var dateTime = DateTime.now();
  }
  return 0;
}

class _State extends State<AsyncTestPage> {
  int lastExeTime = DateTime.now().microsecondsSinceEpoch;
  bool taskIsFinished = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("flutter 异步测试和耗时任务卡顿UI验证")),
        body: SafeArea(
          child: ListView(
            children: [
              ElevatedButton(
                  child: const Text("flutter 异步测试1"),
                  onPressed: () async {
                    ExeTimer timer = ExeTimer();
                    Future.delayed(const Duration(milliseconds: 200), () {});
                    timer.printExeTime(); // 耗时 0/1毫秒 正常异步
                  }),
              ElevatedButton(
                  child: const Text("flutter 节流-异步等待测试2"),
                  onPressed: () async {
                    // debounce防抖  节流（throttle）
                    EasyThrottle.throttle('async-throttle-2', const Duration(milliseconds: 2000), () async {
                      ExeTimer timer = ExeTimer();
                      await Future.delayed(const Duration(milliseconds: 2000));
                      timer.printExeTime(); // 耗时 2002毫秒 异步等待 正常
                    });
                  }),
              ElevatedButton(
                  child: const Text("flutter 节流-异步密集运算测试-卡UI"),
                  onPressed: () async {
                    // debounce防抖  节流（throttle）
                    EasyThrottle.throttle('async-throttle-3', const Duration(milliseconds: 2000), () async {
                      ExeTimer timer = ExeTimer();
                      Future.delayed(const Duration(milliseconds: 0), () {
                        for (int i = 0; i < 10000000; i++) {
                          var dateTime = DateTime.now();
                        }
                        timer.printExeTime(tag: '异步2');
                      });
                      timer.printExeTime(tag: '异步1'); // 耗时 2000多 毫秒 并且UI被卡住了
                    });
                  }),

              ElevatedButton(
                  child: const Text("flutter 防抖-验证"),
                  onPressed: () async {
                    EasyDebounce.debounce('async-throttle-5', const Duration(milliseconds: 100), () {
                      int cost = DateTime.now().millisecondsSinceEpoch - lastExeTime;
                      Log.d("====执行了======cost time: $cost");
                      lastExeTime = DateTime.now().millisecondsSinceEpoch;
                    });
                  }),
              ElevatedButton(
                  child: const Text("flutter 异步Isolate密集运算测试-不卡UI"),
                  onPressed: () async {
                    if(taskIsFinished){
                      ExeTimer timer = ExeTimer();
                      taskIsFinished = false;
                      await compute<String, int>(computeTask, '');
                      timer.printExeTime(tag: '密集计算任务耗时 '); // 耗时 2000多 毫秒 并且UI未被卡住
                      taskIsFinished = true;
                    }

                  }),
            ],
          ),
        ));
  }
}
