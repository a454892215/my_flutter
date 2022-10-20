import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/Log.dart';

class CartModel extends ChangeNotifier {
  final List<Object> _mList = ['a', 3];

  /// ?
  UnmodifiableListView<Object> get items => UnmodifiableListView(_mList);

  /// 使用get 关键字定义只读属性
  int get totalPrice => _mList.length * 6;

  void add(Object item) {
    _mList.add(item);

    /// 通知数据改变
    notifyListeners();
  }

  void removeAll() {
    _mList.clear();

    /// 通知数据改变
    notifyListeners();
  }
}

void test() {
  CartModel model = CartModel();
  Log.d(" 1. model.totalPrice: ${model.totalPrice}");
  model.addListener(() {
    Log.d(" 2. model.totalPrice: ${model.totalPrice}");
  });
  model.add('Dash');
}

main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: _MyApp(),
    ),
  );
}

class _MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "ChangeNotifier测试");
  }
}
