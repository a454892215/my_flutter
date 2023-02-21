import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_lib_3/util/Log.dart';
import 'package:my_flutter_lib_3/util/flutter_stack_trace.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'globe_exception_catch.dart';
import 'material_apps.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // 保证 WidgetsBindingObserver使用时候，已经初始化
   GlobeExceptionHandler().init(() => runApp(buildScreenUtilInit(child: getRootWidget())));
  //FlutterChain.capture(() => runApp(buildScreenUtilInit(child: getRootWidget())));
  if (Platform.isAndroid) {
    /// 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

Widget getRootWidget() {
  return RefreshConfiguration(
    headerBuilder: () => const ClassicHeader(refreshingIcon: CupertinoActivityIndicator()),
    footerBuilder: () => const ClassicFooter(loadingIcon: CupertinoActivityIndicator()),
    hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
    enableBallisticLoad: false, // 可以通过惯性滑动触发加载更多
    enableBallisticRefresh: false,
    child: Builder(builder: (context){
      Log.d("===根页面重构？===Builder========");
      return getMaterialApp(context);
    })
  );
}

/// 屏幕适配配置，单位为1080px*1920px
Widget buildScreenUtilInit({required Widget child}) {
  return ScreenUtilInit(
    designSize: const Size(1080, 1920),
    minTextAdapt: true,
    builder: (context, widget) => child,
  );
}
