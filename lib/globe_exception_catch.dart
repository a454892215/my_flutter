import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/Log.dart';
import 'package:my_flutter_lib_3/util/file_dir_util.dart';

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

  String sepMark = '\r\n\r\n';

  void reportException(FlutterErrorDetails details, int type) {
    var errorMsg = 'exception: ${details.exceptionAsString()} \r\n${details.stack.toString()}';
    String splitMark = '    ';
    List<String> errInfoList = errorMsg.split(splitMark);
    if (errInfoList.length > 101) {
      errInfoList = errInfoList.sublist(0, 101);
    }
    errorMsg = errInfoList.join(splitMark);
    saveLogToLocal(errorMsg);
    Log.e("Not catch Exception type: $type: lineNum:${errInfoList.length}  $errorMsg");
  }

  Future<void> saveLogToLocal(String log) async {
    Directory tempDir = await FileU.getTemporaryDirectoryPath();
    String filePath = tempDir.path;
    File file = File('$filePath/ExceptionLog.txt');
    bool isExist = await file.exists();
    if (isExist) {
      var mb = await file.length() / 1024 / 1024;
      if (mb >= 5) {
        // 如果保存的异常数据大小大于阈值，清空一半异常数据
        removeOldLog(file);
      }
      Log.d("log file Size: $mb MB");
    } else {
      file = await file.create();
      isExist = await file.exists();
      Log.d('exception log file is not exist and has created finished：$isExist');
    }
    log = '$sepMark${DateTime.now()}\r\n$log';
    file.writeAsString(log, mode: FileMode.append);
    Log.d("exception log has saved to local，path: ${file.path}");
  }

  Future<void> removeOldLog(File logFile) async {
    String log = await logFile.readAsString();
    List<String> logList = log.split(sepMark);
    if (logList.length > 1) {
      int start = logList.length ~/ 2;
      var sublist = logList.sublist(start);
      String newLog = sublist.join(sepMark);
      logFile.writeAsString(newLog, mode: FileMode.write);
    }
  }
}
