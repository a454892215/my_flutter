import '../util/Log.dart';

///1. 两个点（..） ..称为级联符号象，可以实现对一个对象的连续调用:列如有一个对象A，我要调用A里面的方法然后将A返回
class A {
  a() {}

  b() {}

  c() {}
}

///2. 三个点（...） ...用来拼接集合，如List，Map等

main() {
  A a = A()
    ..a()
    ..b()
    ..c();
  var list2 = ['d', 'e', 'f'];
  var list = ['a', 'b', 'c', ...list2];
  Log.d("list： $list");
}
