import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// provider使用示例
///   01. ChangeNotifier：模型类，状态发生改变时调用 notifyListeners()
///   02. ChangeNotifierProvider ：负责监听模型变化从而通知Consumer
///   03. Consumer：消费者类，收到通知负责重构UI, StatelessWidget继承了StatelessWidget
main() {
  runApp(_MyApp());
}

class CounterNotifier with ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    _notification();
  }

  void decrement() {
    count--;
    _notification();
  }

  void _notification() {
    notifyListeners();
  }
}

class _MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "provider使用示例",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("provider使用示例"),
        ),
        // 01. ChangeNotifierProvider包过结点
        body: ChangeNotifierProvider(
          lazy: true,
          create: (BuildContext context) => CounterNotifier(),
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
        const Text('Counter', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
        //02.  使用Consumer控件定义需要更新的Widget
        Consumer<CounterNotifier>(
          builder: (BuildContext context, notifier, Widget? child) {
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
