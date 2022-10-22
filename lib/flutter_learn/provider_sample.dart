import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/Log.dart';

/// provider使用示例
///   01. ChangeNotifier：模型类，状态发生改变时调用 notifyListeners()通知数据发生变化
///   02. MultiProvider[ChangeNotifierProvider...] ：负责监听模型变化从而通知Consumer更新UI
///   03. Consumer：消费者类，收到通知重构UI, Consumer是 StatelessWidget子类
///   04.技巧1：Consumer 放在 widget 树尽量低的位置上， 使重构的widget尽量少
///   05.技巧2：Provider.of<CounterNotifier>(context, listen: false).clear(); 用来访问Notifier模型中不需要更新UI的函数
///
/*
Consumer<_MyValuesNotifier>(builder: (context, notifier, child){
return Center();
}),

MultiProvider(
       providers: [
         ChangeNotifierProvider(create: (context) => ChangeNotifier()),
         //  Provider(create: (context) => SomeOtherClass()),
       ],
       child: const Center(),
     ),
*/

main() {
  runApp(_getMaterialApp());
}

MaterialApp _getMaterialApp() {
  return const MaterialApp(
    title: "provider使用示例",
    home: ProviderSamplePage(),
  );
}

class ProviderSamplePage extends StatelessWidget {
  const ProviderSamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("provider使用示例"),
      ),

      /// 01. ChangeNotifierProvider 包裹需要使用Consumer更新UI的结点
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CounterNotifier()),
          //  Provider(create: (context) => SomeOtherClass()),
        ],
        child: const _Page(),
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

        /// 02.  使用Consumer控件定义需要更新的Widget
        Consumer<CounterNotifier>(
          ///notifier: 模型实例。通过该实例修改模型更新UI
          ///child: 用于优化目的。如果 Consumer下面有一个庞大的子树，当模型发生改变的时候，该子树并不会改变，那么你就可以仅仅创建它一次，然后通过 builder获得该实例
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

            /// 03. 调用 BuildContext 对象的read函数，传入CounterNotifier泛型。调用Notifier目标函数更改数据，触发更新
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

  /// 不需要更新UI的函数
  void clear() {
    count = 0;
  }
}
