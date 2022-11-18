import '../util/Log.dart';

class A {
  void testPrint() {
    List<String> list = StackTrace.current.toString().split("\n");
    Log.d("list.length: ${list.length}");
  }
}

main() {
  A().testPrint();
}
