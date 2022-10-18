import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/LogUtil.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

import 'main/note01.dart';

void main() {
  runApp(const MyApp2());
}
class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false, // 加入这行代码,即可关闭'DEBUG'字样
      title: "页面标签标题",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    //  home: getWidget01(),
    //  home: const StatelessWidget01(),
      home: const ContextRoute(),
    //  home: const EchoWidget(text: "EchoWidget测试",),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '页面标签标题',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '标题栏标题'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() { // 执行后会刷新build函数
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
     Toast.toast("build=gaga");
    LogUtil.d("==========build=================_counter:$_counter");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
