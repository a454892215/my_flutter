import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/Log.dart';

typedef VoidCallback = void Function();

class GlobeExceptionHandler {
  void init(VoidCallback onRunApp) {
    /// 1. 获取 widget build 过程中出现的异常错误
    FlutterError.onError = (FlutterErrorDetails details) {
      reportLog(details);
    };

    runZonedGuarded(
      () => onRunApp(),
      (error, stackTrace) {
        /// 2. 没被catch的异常
        reportLog(FlutterErrorDetails(exception: error, stack: stackTrace));
      },
    );
  }

  void reportLog(FlutterErrorDetails details) {
    final errorMsg = {
      "exception": details.exceptionAsString(),
      "stackTrace": details.stack.toString(),
    };

    /// TODO 上报错误
    Log.e("GlobeExeHandler-发生了异常 : $errorMsg");
  }
}
