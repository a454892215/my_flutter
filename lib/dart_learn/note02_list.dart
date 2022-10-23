import '../util/Log.dart';

/// List 集合类型： 存入的数据是有序的， 数组使用List集合表示
main() {
  /// 01. 集合的声明
  var ls1 = [9, 2, 3, 4];
  var ls2 = [9, 2, "3", 4];
  Log.d("ls 运行时候的类型是：${ls1.runtimeType}"); // 输出 List<int> ， 为什么运行时候类型带有泛型？？？
  Log.d("ls2 运行时候的类型是：${ls2.runtimeType}"); // 输出 List<Object>

  /// 02. 集合常用api示例: first, last, length, add, insert, remove, clear
  Log.d("List集合的首个元素是：${ls1.first}");
  Log.d("List集合的最后一个元素是：${ls1.last}");
  Log.d("List集合的元素总个数是：${ls1.length}");
  Log.d("List集合是否没有元素：${ls1.isEmpty}");
  ls2.add("add 加入值1");
  ls2.insert(0, "insert 加入值1");
  Log.d("List集合使用 add() 和 insert()添加元素：$ls2");
  ls2.remove("add 加入值1");
  Log.d("List集合使用 验证 remove() ：$ls2");
  var removedObj = ls2.removeAt(1);
  Log.d("List集合使用 验证 removeAt() ：$ls2  被删除的元素：$removedObj");
  ls2.clear();
  Log.d("List集合使用 验证 clear() ：$ls2");

  /// map迭代
  var ls5 = [9, 2, 3, 4];
  var ret = ls5.map((e) => e).toList();
  Log.d("map 迭代：$ret");
}
