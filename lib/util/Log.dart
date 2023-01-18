// import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import '../env.dart';

class Log {
  static const String tag = "LLpp:";
  static const debugEnable = EnvironmentConfig.APP_ENV == 'debug';
  static var logger = Logger(
    printer: MyLogPrinter(),
  );

  static void d(dynamic msg) {
    if (debugEnable) {
      _print(Level.debug, msg);
    }
  }

  static void i(dynamic msg) {
    _print(Level.info, msg);
  }

  static void e(dynamic msg) {
    _print(Level.error, msg);
  }

  static void _print(Level level, dynamic msg) {
    var traceList = StackTrace.current.toString().replaceAll(RegExp(r"(\s\s\s\s)+"), "    ").split("\n");
    String pre = traceList[0];
    bool isLocated = false;
    for (int i = 1; i <= 5; i++) {
      var cur = traceList[i];
      if (pre.contains("/Log.") && !cur.contains("/Log.")) {
        logger.log(level, "${DateTime.now()} $cur $tag$msg");
        isLocated = true;
        break;
      }
      pre = traceList[i];
    }
    if(!isLocated){
      logger.log(level, "${DateTime.now()} 未定位到调用位置 $tag$msg");
    }
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
