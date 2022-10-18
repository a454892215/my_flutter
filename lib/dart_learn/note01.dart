///
///   final 可以开始不复值 只复值一次
///   const定义常量, 不能再修改 否则报错
const name = "note01"; //

void main() {
  print("========note01=======：$name");
  // 01. dart变量命名规则 不能以数字开头，不能是关键字 不能有空格等...
  const age = 12; // var申明的变量 类型一单给定，不能换其他类型赋值

  //02. 常用数据类型：int, double, bool ,String List Map
  int i1 = 19;
  double d2 = 19;
  String s1 = "19";
  bool b1 = false;
  List ls = [10, 12];
  Map map = {"a1": "a2", "b1": "b2"};
  print("Ls: $ls  ${ls.length}");
  print("map: $map  ${ls.length}");

  // 03. 声明变量的三种方式： 01.dynamic  02.var  03.具体类型申明
  dynamic dd1 = "a";
  var vv1 = "a";
  String ss1 = "a";
}
