import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'material_apps.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // 保证 WidgetsBindingObserver使用时候，已经初始化
  runApp(buildScreenUtilInit(child: getMaterialApp()));
}

/// 屏幕适配配置，单位为1080px*1920px
Widget buildScreenUtilInit({required Widget child}) {
  return ScreenUtilInit(
    designSize: const Size(1080, 1920),
    minTextAdapt: true,
    builder: (context, widget) => child,
  );
}
