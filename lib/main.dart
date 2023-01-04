import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'globe_exception_catch.dart';
import 'material_apps.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // 保证 WidgetsBindingObserver使用时候，已经初始化
  GlobeExceptionHandler().init(() => runApp(buildScreenUtilInit(child: getMaterialApp())));
  if (Platform.isAndroid) {
    /// 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

/// 屏幕适配配置，单位为1080px*1920px
Widget buildScreenUtilInit({required Widget child}) {
  return ScreenUtilInit(
    designSize: const Size(1080, 1920),
    minTextAdapt: true,
    builder: (context, widget) => child,
  );
}
