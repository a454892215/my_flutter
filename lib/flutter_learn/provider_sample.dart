import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/Log.dart';

/// provider使用示例
///   01. ChangeNotifier：模型类，状态发生改变时调用 notifyListeners()通知数据发生变化
///   02. MultiProvider/ChangeNotifierProvider ：负责监听模型变化从而通知Consumer更新UI
///   03. Consumer：消费者类，收到通知重构UI, Consumer是 StatelessWidget子类
main() {
  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "provider使用示例",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("provider使用示例"),
        ),
        // 01. ChangeNotifierProvider 包裹需要使用Consumer更新UI的结点
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CounterNotifier()),
          //  Provider(create: (context) => SomeOtherClass()),
          ],
          child: const _Page(),
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Counter', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.blue)),
        //02.  使用Consumer控件定义需要更新的Widget
        Consumer<CounterNotifier>(
          builder: (BuildContext context, notifier, Widget? child) {
            // child 返回null
            Log.d("==Consumer=builder====child:${child?.runtimeType}");
            return Text(
              notifier.count.toString(),
              style: const TextStyle(fontSize: 38),
            );
          },
        ),
        TextButton.icon(
            // 03. 调用 BuildContext 对象的read函数，传入CounterNotifier泛型。调用Notifier目标函数更改数据，触发更新
            onPressed: () => context.read<CounterNotifier>().increment(),
            label: const Text('increment'),
            icon: const Icon(Icons.add)),
      ]),
    );
  }
}

class CounterNotifier with ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}
