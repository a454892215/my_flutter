import 'package:flutter/material.dart';

import '../util/Log.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: WidgetsBindingObserverTestPage(),
  ));
}

class WidgetsBindingObserverTestPage extends StatefulWidget {
  const WidgetsBindingObserverTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<WidgetsBindingObserverTestPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive: // 不清楚什么状态
        Log.d('====inactive======');
        break;
      case AppLifecycleState.resumed: // 从后台切换前台，界面可见
        Log.d('=======resumed======');
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        Log.d('=======paused======');
        break;
      case AppLifecycleState.detached: // App 结束
        Log.d('=======detached======');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          AppBar(
            title: const Text("WidgetsBindingObserverTestPage"),
          )
        ],
      ),
    ));
  }
}
