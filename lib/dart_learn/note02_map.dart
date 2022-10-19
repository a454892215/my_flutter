import '../util/Log.dart';

/// Map： 键值对集合，键不能重复，值可以重复
main() {
  ///基本属性
// | 名称 | 说明 |
// | —— | —— |
// | isEmpty | 是否为空 |
// | isNotEmpty | 是否不为空 |
// | keys | key 集合 |
// | values | values 集合 |
// | length | 个数 |
// | entries | 加工数据入口 |

  Map map = {"k1": "k1-123"};
  Log.d("map.runtimeType ${map.runtimeType}");

  /// addAll
  map.addAll({"k2": 123, "k3": 123});
  Map map2 = {"s1": 123, "s2": 123};

  /// addEntries
  map.addEntries(map2.entries);
  Log.d("map.runtimeType $map");

  /// containsKey
  Log.d("map.containsKey: ${map.containsKey("k2")}");

  /// containsValue
  Log.d("map.containsValue: ${map.containsValue(123)}");

  /// remove
  Log.d("map.remove: ${map.remove("k1")}");

  /// removeWhere 条件删除
  map.removeWhere((key, val) => key == "k2");

  /// update()  根据key跟新数据： key 不存在会报异常
  map.update("s2", (val) => "s2-123");
  Log.d(map);
  /// 取值
  Log.d(map["s2"]);
  /// 赋值
  map["s2"] = "s2-999";
  Log.d(map);
}
