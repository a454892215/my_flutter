import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/Log.dart';
import 'package:path_provider/path_provider.dart';

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
    final errorMsg = 'exception: ${details.exceptionAsString()} \r\n${details.stack.toString()}';
    saveLogToLocal(errorMsg);
    Log.e("Not catch Exception type: $type: $errorMsg");
  }

  Future<void> saveLogToLocal(String log) async {
    Directory tempDir = await getTemporaryDirectory();
    String filePath = tempDir.path;
    File file = File('$filePath/ExceptionLog.txt');
    bool isExist = await file.exists();
    if (!isExist) {
      file = await file.create();
      isExist = await file.exists();
      Log.d('filePath: exception log file is not exist and has created finished：$isExist');
    }
    log = '\r\n\r\n${DateTime.now()}\r\n$log';
    file.writeAsString(log, mode: FileMode.append);
    Log.d("exception log has saved to local，path: ${file.path}");
  }
}
