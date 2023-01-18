import 'Log.dart';

class ExeTimer {
  int start = 0;
  int exeIndex = 0;
  ExeTimer() {
    start = DateTime.now().millisecondsSinceEpoch;
  }

  void printExeTime({String tag = ''}) {
    int end = DateTime.now().millisecondsSinceEpoch;
    int costTime = end - start;
    Log.d("$tag exeIndex:$exeIndex costTime: $costTime");
    exeIndex++;
  }
}
