import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';
import 'dart:async';

typedef OnError = void Function(dynamic error, Chain chain);
typedef VoidCallback = void Function();

class FlutterChain {
  FlutterChain._();

  static void capture<T>(
    VoidCallback onRunApp, {
    OnError? onError,
    bool simple = true,
  }) {
    Isolate.current.addErrorListener(RawReceivePort((dynamic pair) async {
      var isolateError = pair as List<dynamic>;
      var error = isolateError.first;
      var stackTrace = isolateError.last;
      Zone.current.handleUncaughtError(error, stackTrace);
    }).sendPort);
    runZonedGuarded(
      () {
        FlutterError.onError = (FlutterErrorDetails details) async {
          Zone.current.handleUncaughtError(details.exception, details.stack!);
        };
        onRunApp();
      },
      (error, stack) {
        printError(error, stack);
      },
    );
    FlutterError.onError = (FlutterErrorDetails details) async {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    };
  }

  static printError(error, stack, {bool simple = false}) {
    String errorStr = "";
    if (simple) {
      errorStr = _parseFlutterStack(Trace.from(stack));
    } else {
      errorStr = Trace.from(stack).toString();
    }
    errorStr = errorStr.trim().replaceAll("\n", " ");
    if (errorStr.isNotEmpty) {
      var content = "$error => $errorStr";
      String log = "${DateTime.now()}:  $content";
      debugPrint(log);
    }
  }

  static String _parseFlutterStack(Trace trace) {
    String result = "";
    String traceStr = trace.toString();
    List<String> strs = traceStr.split("\n");
    for (var str in strs) {
      if (!str.contains("package:flutter/") && !str.contains("dart:") && !str.contains("package:flutter_stack_trace/")) {
        if (str.isNotEmpty) {
          if (result.isNotEmpty) {
            result = "$result\n$str";
          } else {
            result = str;
          }
        }
      }
    }
    return result;
  }
}

int _getMaxLength(List<String> logSlice) {
  List<int> lengthList = <int>[];
  for (var log in logSlice) {
    lengthList.add(log.length);
  }
  lengthList.sort((left, right) => right - left);
  return lengthList[0];
}
