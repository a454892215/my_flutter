// import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

class Log {
  static const String tag = "LLpp:";
  static const debug = true;
  static var logger = Logger(
    printer: MyLogPrinter(),
  );


  static void d(Object msg) {
    if (debug) {
      var traceList = StackTrace.current.toString().split("\n");
      logger.d("${traceList[1]} $tag$msg");
    }
  }

  static void e(Object msg) {
    var traceList = StackTrace.current.toString().split("\n");
    logger.e("${traceList[1]} $tag$msg");
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
