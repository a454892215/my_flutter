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
    var errorMsg = 'exception: ${details.exceptionAsString()} \r\n${details.stack.toString()}';
    String splitMark = '    ';
    List<String> errInfoList = errorMsg.split(splitMark);
    if(errInfoList.length > 101){
      errInfoList = errInfoList.sublist(0, 101);
    }
    errorMsg = errInfoList.join(splitMark);
    saveLogToLocal(errorMsg);
    Log.e("Not catch Exception type: $type: lineNum:${errInfoList.length}  $errorMsg");
  }

  Future<void> saveLogToLocal(String log) async {
    Directory tempDir = await getTemporaryDirectory();
    String filePath = tempDir.path;
    File file = File('$filePath/ExceptionLog.txt');
    bool isExist = await file.exists();
    if (isExist) {
      var mb = await file.length() / 1024 / 1024;
      if (mb >= 10) {
        file.writeAsString('', mode: FileMode.write);
      }
      Log.d("log file Size: $mb MB");
    } else {
      file = await file.create();
      isExist = await file.exists();
      Log.d('exception log file is not exist and has created finished：$isExist');
    }
    log = '\r\n\r\n${DateTime.now()}\r\n$log';
    file.writeAsString(log, mode: FileMode.append);
    Log.d("exception log has saved to local，path: ${file.path}");
  }
}
