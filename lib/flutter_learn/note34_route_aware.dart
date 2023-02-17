
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../lib_samples/note08_reskin.dart';
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

  /// 第一次进入执行
  @override
  void didChangeDependencies() {
    Log.d("===第一次进入执行==didChangeDependencies====== $widget");
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute); //Subscribe it here
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    Log.d('=========didPopNext====回到此页面执行===== currentRoute:${Get.currentRoute} ===');
  }

  /// 第一次进入执行
  @override
  void didPush() {
    Log.d('=========didPush===第一次进入执行==== currentRoute:${Get.currentRoute} =======');
  }

  @override
  void didPop() {
    Log.d('=========didPop====退出此页面执行========');
  }

  @override
  void didPushNext() {
    Log.d('=========didPushNext=====离开此页面执行=== currentRoute:${Get.currentRoute} ====');
  }

  @override
  void dispose() {
    Log.d('=========dispose=======销毁此页面执行=====');
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
            child: CupertinoButton(
              onPressed: () {
                Get.to(() => const ChangeSkinPage());
              },
              child: const Text("去换肤页面"),
            ),
          )
        ],
      ),
    ));
  }
}
