import 'package:flutter/material.dart';

class LogUtil {
  static final String tag = "LLpp:";

  static void d(String msg) {
    debugPrint(tag + msg);
  }
}
