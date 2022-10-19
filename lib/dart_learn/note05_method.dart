import '../util/Log.dart';

/// 匿名方法 用一个变量接受
var func = (a) {
  Log.d("我是匿名方法$a");
};

main() {
  func("a123");
}
