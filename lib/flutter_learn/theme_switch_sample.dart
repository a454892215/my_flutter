import 'package:flutter/material.dart';

import '../util/Log.dart';

main() {
  runApp(const _MyApp());
}

class _MyApp extends StatefulWidget {
  const _MyApp();

  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State {
  ThemeData _curTheme = ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark);

  void onSwitchTheme(int type) {
    /// setState 触发Widget build(BuildContext context)函数再次执行
    setState(() {
      if (type == 1) {
        _curTheme = ThemeData(brightness: Brightness.light);
      } else if (type == 2) {
        _curTheme = ThemeData(brightness: Brightness.dark);
      } else if (type == 3) {
        _curTheme = ThemeData(
            primarySwatch: Colors.purple,
            backgroundColor: Colors.red,
            //  body 背景颜色
            canvasColor: Colors.blue,
            brightness: Brightness.light);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Log.d("=====build=======MaterialApp被创建=====:$hashCode");
    return MaterialApp(
      title: "theme selector",
      theme: _curTheme,
      home: Scaffold(
        appBar: AppBar(title: const Text("theme-selector")),
        body: _getTopCenterAlign(),
      ),
    );
  }

  Align _getTopCenterAlign() {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(children: _getBtnList()),
    );
  }

  List<Widget> _getBtnList() {
    return [
      ElevatedButton(
          onPressed: () {
            onSwitchTheme(1);
          },
          child: const Text("light")),
      ElevatedButton(
          onPressed: () {
            onSwitchTheme(2);
          },
          child: const Text("dark")),
      ElevatedButton(
          onPressed: () {
            onSwitchTheme(3);
          },
          child: const Text("蓝色")),
    ];
  }
}
