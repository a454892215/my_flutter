import 'package:flutter/material.dart';

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
        print('====inactive======');
        break;
      case AppLifecycleState.resumed: // 从后台切换前台，界面可见
        print('=======resumed======');
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        print('=======paused======');
        break;
      case AppLifecycleState.detached: // App 结束
        print('=======detached======');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xffff9ef0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [],
        ),
      ),
    );
  }
}
