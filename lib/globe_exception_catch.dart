import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/Log.dart';

typedef VoidCallback = void Function();

class GlobeExceptionHandler {
  /// 1. 同步异常
  void init(VoidCallback onRunApp) {
    FlutterError.onError = (FlutterErrorDetails details) {
      reportException(details, 0);
    };

    runZonedGuarded(
      () => onRunApp(),
      (error, stackTrace) {
        ///2. 异步异常
        reportException(FlutterErrorDetails(exception: error, stack: stackTrace), 1);
      },
    );
  }

  void reportException(FlutterErrorDetails details, int type) {
    final errorMsg = {"exception": details.exceptionAsString(), "stackTrace": details.stack.toString()};

    /// TODO 上报错误
    Log.e("Not catch Exception type: $type: $errorMsg");
  }
}
