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
        printError(error, stack, simple: simple);
      },
    );
    FlutterError.onError = (FlutterErrorDetails details) async {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    };
  }

  static printError(error, stack, {bool simple = true}) {
    debugLog(error.toString(), isShowTime: false, showLine: true, isDescription: true);
    String errorStr = "";
    if (simple) {
      errorStr = _parseFlutterStack(Trace.from(stack));
    } else {
      errorStr = Trace.from(stack).toString();
    }
    if (errorStr.isNotEmpty) {
      debugLog(errorStr, isShowTime: false, showLine: true, isDescription: false);
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

///
/// print message when debug.
///
/// `maxLength` takes effect when `isDescription = true`, You can edit it based on your console width
///
/// `isDescription` means you're about to print a long text
///
/// debugLog(
///   "1234567890",
///   isDescription: true,
///   maxLength: 1,
/// );
///  ------
///  | 1  |
///  | 2  |
///  | 3  |
///  | 4  |
///  | 5  |
///  | 6  |
///  | 7  |
///  | 8  |
///  | 9  |
///  | 0  |
///  ------
///

void debugLog(Object obj, {bool isShowTime = false, bool showLine = true, int maxLength = 100, bool isDescription = true}) {
  bool isDebug = false;
  assert(isDebug = true);

  if (isDebug) {
    String slice = obj.toString();
    if (isDescription) {
      if (obj.toString().length > maxLength) {
        List<String> objSlice = [];
        for (int i = 0;
            i < (obj.toString().length % maxLength == 0 ? obj.toString().length / maxLength : obj.toString().length / maxLength + 1);
            i++) {
          if (maxLength * i > obj.toString().length) {
            break;
          }
          objSlice.add(
              obj.toString().substring(maxLength * i, maxLength * (i + 1) > obj.toString().length ? obj.toString().length : maxLength * (i + 1)));
        }
        slice = "\n";
        for (var element in objSlice) {
          slice += "$element\n";
        }
      }
    }
    _print(slice, showLine: showLine, isShowTime: isShowTime);
  }
}

_print(String content, {bool isShowTime = true, bool showLine = false}) {
  String log = isShowTime ? "${DateTime.now()}:  $content" : content;
  if (showLine) {
    var logSlice = log.split("\n");
    int maxLength = _getMaxLength(logSlice) + 3;
    String line = "-";
    for (int i = 0; i < maxLength + 1; i++) {
      line = "$line-";
    }
    debugPrint(line);
    for (var log in logSlice) {
      if (log.isEmpty) {
        continue;
      }
      int gapLength = maxLength - log.length;
      if (gapLength > 0) {
        String space = " ";
        for (int i = 0; i < gapLength - 3; i++) {
          space = "$space ";
        }
        debugPrint("| $log$space |");
      }
    }
    debugPrint(line);
  } else {
    debugPrint(log);
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
