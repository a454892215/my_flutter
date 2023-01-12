// import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

class Log {
  static const String tag = "LLpp:";
  static const debug = true;
  static var logger = Logger(
    printer: MyLogPrinter(),
  );

  static void d(dynamic msg) {
    if (debug) {
      _print(Level.debug, msg);
    }
  }

  static void e(dynamic msg) {
    _print(Level.error, msg);
  }

  static void _print(Level level, dynamic msg) {
    var traceList = StackTrace.current.toString().replaceAll(RegExp(r"(\s\s\s\s)+"), "    ").split("\n");
    String pre = traceList[0];
    for (int i = 1; i <= 5; i++) {
      var cur = traceList[i];
      if (pre.contains("/Log.") && !cur.contains("/Log.")) {
        logger.log(level, "$cur $tag$msg");
        break;
      }
      pre = traceList[i];
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
