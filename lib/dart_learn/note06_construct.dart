import '../util/Log.dart';

/// 1. 普通构造函数
class St1 {
  int? age;
  String? name;

  St1(int age, String name) {
    this.age = age;
    this.name = name;
  }

  @override
  String toString() {
    return "$runtimeType age:$age  name: $name";
  }
}

/// 2. 自动赋值成员变量的构造函数
class St2 {
  int? age;
  String? name;

  //
  St2(this.age, this.name);

  @override
  String toString() {
    return "$runtimeType  age: $age  name: $name";
  }
}

/// 3. 命名构造函数: 命名构造函数不可继承，如果子类想要有和父类一样的命名构造函数，编译器会提示创建自己的该命名构造函数，
/// 并调用父类的该命名构造函数，代码如下
class St3 {
  int? age;
  String? name;

  St3.createInstance(this.age, this.name);

  @override
  String toString() {
    return "$runtimeType  age: $age  name: $name";
  }
}

/// 3. 命名构造函数子类
class St3Sub extends St3 {
  St3Sub.createInstance(super.age, super.name) : super.createInstance();

  @override
  String toString() {
    return "$runtimeType  age: $age  name: $name";
  }
}

/// 4. 常量构造函数： 1.所有实例变量都是final， 2.构造器前必须有const，且不能有函数体, 常量构造函数创建的对象前面也最好加上const
class St4 {
  final int age;
  final String name;

  const St4(this.age, this.name);

  @override
  String toString() {
    return "$runtimeType  age: $age  name: $name";
  }
}

/// 5. 工厂构造函数： 单例
class St5 {
  int age;
  String name;

  static final St5 _singleton = St5._internal1(12, "tom");

  /// 01. 暴露的构造函 使用factory修饰 不能使用 this 声明构造函数参数自动赋值
  factory St5(int age, String name) {
    _singleton.age = age;
    _singleton.name = name;
    return _singleton;
  }

  /// 02. 实际的构造函数私有
  St5._internal1(this.age, this.name);

  @override
  String toString() {
    return "$runtimeType  age: $age  name: $name";
  }
}

main() {
  Log.d(St1(11, "sand"));
  Log.d(St2(111, "sandy"));
  Log.d(St3.createInstance(111, "sandy"));
  Log.d(St3Sub.createInstance(111, "sandy"));
  Log.d(const St4(111, "sandy"));
  Log.d(St5(1112, "alen"));
}
