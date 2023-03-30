
import 'package:logger/logger.dart';


class Log {
  static const String tag = "LLpp:";
  static bool isDebug = false;
  static bool debugEnable = isDebugMode();
  static var logger = Logger(
    // printer: MyLogPrinter(),
    printer: SimplePrinter(),
  );

  static bool isDebugMode() {
    assert(() {
      isDebug = true;
      return true;
    }());
    print("LLpp 是否debug 环境：$isDebug");
    return isDebug;
  }

  static void d(dynamic msg, {int traceDepth = 1}) {
    if (debugEnable) {
      _print(Level.debug, msg, traceDepth: traceDepth);
    }
  }

  static void i(dynamic msg) {
    _print(Level.info, msg);
  }

  static void w(dynamic msg) {
    _print(Level.warning, msg);
  }

  static void e(dynamic msg) {
    _print(Level.error, msg);
  }

  static void _print(Level level, dynamic msg, {int traceDepth = 1}) {
    String traceInfo = getTraceInfo(level, traceDepth: traceDepth);
    logger.log(level, "${DateTime.now()} $traceInfo $tag$msg");
  }

  static String getTraceInfo(Level level, {int traceDepth = 1}) {
    try {
      var traceList = StackTrace.current.toString().replaceAll(RegExp(r"(\s\s\s\s)+"), "    ").split("\n");
      String pre = traceList[0];
      String traceInfo = '未定位到调用位置';
      int end = traceList.length > 6 ? 6 : traceList.length;
      List<String> tarTraceList = [];
      for (int i = 1; i < end; i++) {
        var cur = traceList[i];
        if (pre.contains("Log.") && !cur.contains("Log.")) {
          traceInfo = cur;
          int end2 = i + traceDepth;
          end2 = end2 > traceList.length ? traceList.length : end2;
          for (int j = i; j < end2; j++) {
            var cur = traceList[j];
            tarTraceList.add(cur);
          }
          break;
        }
        pre = traceList[i];
      }
      String ret = "";
      var tarSize = tarTraceList.length;
      for (int i = 0; i < tarSize; i++) {
        String item = tarTraceList[i];
        int start = item.indexOf('(package:');
        if(start > -1){
          item = item.substring(start);
        }
        String delimiter = i == tarSize - 1 ? "" : '\r\n';
        ret += '$item$delimiter';
      }
      return ret.isEmpty ? traceInfo : ret;
    } catch (e, trace) {
      logger.log(level, "${DateTime.now()} $e $tag $trace");
    }
    return "定位调用栈发生异常";
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
