// import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import '../env.dart';

class Log {
  static const String tag = "LLpp:";
  static bool isDebug = false;
  static bool debugEnable = EnvironmentConfig.isDebug();
  static var logger = Logger(
    printer: MyLogPrinter(),
  );

  static bool isDebugMode() {
    assert(() {
      isDebug = true;
      return true;
    }());
    return isDebug;
  }

  static void d(dynamic msg) {
    if (debugEnable) {
      _print(Level.debug, msg);
    }
  }

  static void i(dynamic msg) {
    _print(Level.info, msg);
  }

  static void w(dynamic msg) {
    _print(Level.error, msg);
  }

  static void e(dynamic msg) {
    _print(Level.error, msg);
  }

  static void _print(Level level, dynamic msg) {
    String traceInfo = getTraceInfo();
    logger.log(level, "${DateTime.now()} $traceInfo $tag$msg");
  }

  static String getTraceInfo() {
    var traceList = StackTrace.current.toString().replaceAll(RegExp(r"(\s\s\s\s)+"), "    ").split("\n");
    String pre = traceList[0];
    String traceInfo = '未定位到调用位置';
    int end = traceList.length > 6 ? 6 : traceList.length;
    for (int i = 1; i < end; i++) {
      var cur = traceList[i];
      if (pre.contains("Log.") && !cur.contains("Log.")) {
        traceInfo = cur;
        break;
      }
      pre = traceList[i];
    }
    var start = traceInfo.indexOf('(package:');
    traceInfo = traceInfo.substring(start);
    return traceInfo;
  }
}

class MyLogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    return _formatAndPrint(level: event.level, message: event.message);
  }

  List<String> _formatAndPrint({
    required Level level,
    required String message,
  }) {
    List<String> buffer = [];
    var ansiColor = PrettyPrinter.levelColors[level];
    for (var line in message.split('\n')) {
      buffer.add(ansiColor!(line));
    }
    return buffer;
  }
}
