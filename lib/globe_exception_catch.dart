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
    printExceptionLogSummary();
  }

  String sepMark = '\r\n\r\n';

  void reportException(FlutterErrorDetails details, int type) {
    var errorMsg = 'exception: ${details.exceptionAsString()} \r\n${details.stack.toString()}';
    String splitMark = '    ';
    List<String> errInfoList = errorMsg.split(splitMark);
    errInfoList = filterLog(errInfoList);

    if (errInfoList.length > 101) {
      errInfoList = errInfoList.sublist(0, 101);
    }
    errorMsg = errInfoList.join(splitMark);
    appendLogToLocal(errorMsg);
    Log.e("Not catch Exception type: $type: lineNum:${errInfoList.length}  $errorMsg");
  }

  List<String> filterLog(List<String> logList) {
    List<String> ls = [];
    for (String item in logList) {
      if (!item.contains("package:flutter")) {
        ls.add(item);
      }
    }
    return ls;
  }

  Future<File> getLogFile() async {
    Directory tempDir = await FileU.getTemporaryDirectoryPath();
    String filePath = tempDir.path;
    File file = File('$filePath/ExceptionLog.txt');
    bool isExist = await file.exists();
    if (!isExist) {
      file = await file.create();
      isExist = await file.exists();
      Log.d('exception log file is not exist and has created finished：$isExist');
    }
    return file;
  }

  Future<void> appendLogToLocal(String log) async {
    File file = await getLogFile();
    var mb = await file.length() / 1024 / 1024;
    if (mb >= 4) {
      Log.d("当前保存的log文件大小超标， 开始清空部分log  当前log文件size：${mb.toStringAsFixed(2)}-MB");
      removeOldLog(file);
    }
    log = '${DateTime.now()}\r\n$log$sepMark';
    file.writeAsString(log, mode: FileMode.append);
  }

  Future<void> removeOldLog(File logFile) async {
    String log = await logFile.readAsString();
    List<String> logList = log.split(sepMark);
    if (logList.length > 1) {
      int start = logList.length ~/ 2;
      var sublist = logList.sublist(start);
      String newLog = sublist.join(sepMark);
      logFile.writeAsString(newLog, mode: FileMode.write);
      Log.d("删除前的log num是: ${logList.length}  删除后的log num是：${sublist.length}");
    }
  }

  Future<void> printExceptionLogSummary() async {
    File logFile = await getLogFile();
    double mb = await logFile.length() / 1024 / 1024;
    String log = await logFile.readAsString();
    if (log.length > 1) {
      List<String> logList = log.split(sepMark);
      var num = logList.length - 1;
      Log.d("异常log文件大小是：${mb.toStringAsFixed(2)}MB 异常log数目是：$num");
    } else {
      Log.d("本地无缓存异常log...");
    }
  }
}
