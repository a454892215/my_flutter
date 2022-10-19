
import 'package:my_flutter_lib_3/util/Log.dart';

/// 1. 常量的定义
///  01. final 定义常量(不能再修改 否则报错) 可以开始不赋值 后面只能赋值一次
///  02. const 定义常量(不能再修改 否则报错)
const name = "note01";

void main() {
  /// 2. 声明变量的三种方式： 01.dynamic   02.var  03.具体类型申明
  dynamic dd1 = "a";
  var vv1 = "a";
  String ss1 = "a";

  /// 3. 数字类型 num 子类：  1.整型int  2.浮点型double
  ///  01. 使用 num 声明整型或者浮点型变量
  num n1 = 3.5;

  ///  02. 使用 int 声明整型变量
  int i1 = 19;

  /// 03. 使用 double 声明整型或者浮点型变量
  double d2 = 19;

  /// 4.String 类型： 1.使用单引号 也可以使用双引号赋值  2.字符串模板语法${}, 其中{}是单个变量{}可以省略
  String str = 'abc';
  String str2 = "abc";
  String str3 = "123$str";
  Log.d(str3);

  /// 5.bool 类型： 只能赋值true或者false
  bool b1 = true;
  bool b2 = false;


}
