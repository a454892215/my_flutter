// import 'package:flutter/material.dart';

class Log {
  static const String tag = "LLpp:";
  static const debug = true;

  /// debugPrint需要再Flutter环境下运行
  static void d(Object msg) {
    if (debug) {
      print(tag + msg.toString());
    }
  }
}
