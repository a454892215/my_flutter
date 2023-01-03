import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../material_apps.dart';
import '../util/Log.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: RouteAwareTestPage(),
  ));
}

class RouteAwareTestPage extends StatefulWidget {
  const RouteAwareTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<RouteAwareTestPage> with RouteAware {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Log.d("=====didChangeDependencies====== $widget");
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute); //Subscribe it here
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    Log.d('=========didPopNext============');
  }

  @override
  void didPush() {
    Log.d('=========didPush============');
  }

  @override
  void didPop() {
    Log.d('=========didPop============');
  }

  @override
  void didPushNext() {
    Log.d('=========didPushNext============');
  }

  @override
  void dispose() {
    Log.d('=========dispose============');
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    /// 设置单个页面状态栏, 如果页面有AppBar会无效
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.green,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                color: Colors.green,
                height: 150.w,
                alignment: Alignment.center,
                child: const Text("RouteAwareTestPage"),
              )
            ],
          ),
        ));
  }
}
