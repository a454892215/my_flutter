import '../util/Log.dart';

/// Set  唯一无序的集合
main() {
  /// 01. 集合的声明
  Set set = {1, 2, "4", 5, "6", "7", 8, 9};
  set.add("13");
  set.add("12");
  set.add("11");
  set.add("1222");
  set.add("2");
  Log.d("set 运行时候类型: ${set.runtimeType} $set");

  /// 2. 基本属性： isEmpty | first | last | length

  /// 3.常用方法名字
  // | addAll | 添加 |
  set.addAll({333, 2, "444"});
  // | contains | 查询单个 |
  bool isContain = set.contains("value");
  Log.d("isContain:$isContain");
  // | containsAll | 查询多个 |
  // | difference | 集合不同 |
  // | intersection | 交集 |
  // | union | 联合 |
  // | lookup | 按对象查询到返回对象 |
  // | remove | 删除单个 |
  // | removeAll | 删除多个 |
  // | clear | 清空 |
  // | firstWhere | 按条件正向查询 |
  // | lastWhere | 按条件反向查询 |
  // | removeWhere | 按条件删除 |
  // | retainAll | 只保留几个 |
  // | retainWhere | 按条件只保留几个 |
  // ————————————————
  // 版权声明：本文为CSDN博主「雨夜的博客」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
  // 原文链接：https://blog.csdn.net/syx_1990/article/details/117854685
  ///
}
