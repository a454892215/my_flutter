import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/lib_samples/skin/skin_manager.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

import '../util/Log.dart';

class InheritedWidgetPage extends StatefulWidget {
  const InheritedWidgetPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State {
  @override
  void initState() {
    super.initState();
  }

  int _clickCount = 0;
  int _clickCount2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InheritedWidget-示例"),
      ),
      body: ShareDataWidget(
        clickCount: _clickCount,
        child: Align(
          child: GestureDetector(
            onTap: () {
              _clickCount++;
              _clickCount2++;
              setState(() {});
              Log.d("_clickCount:$_clickCount2");
              toast("click");
            },
            child: Container(
              width: 200,
              height: 200,
              color: skin().bgColor1(),

              ///  1. setState后 当子组件是const状态时， 如果子组件没有依赖ShareDataWidget  不会触发子组件刷新
              ///  2. setState后 当子组件是const状态时， 如果子组件依赖ShareDataWidget  会触发子组件调用didChangeDependencies和刷新
              ///  3. setState后 当子组件不是const状态时， 会根据key的规则， 触发子组件调用 didChangeDependencies 和刷新
              ///    01. ValueKey(value) 当值发生变化的时候同时触发didChangeDependencies和build刷新 否则只触发build刷新
              ///    02. ObjectKey(value) ...比较对象是否相同 是否相同后的逻辑同上
              ///    03. UniqueKey 独一无二的key 每次都会触发didChangeDependencies和build刷新
                    /// child: ChildWidget(key: ObjectKey(_clickCount2 % 5 == 0 ? 1 : 0)),
              child: ChildWidget(key: UniqueKey()),
            ),
          ),
        ),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  const ChildWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChildState();
  }
}

class ChildState extends State<ChildWidget> {
  @override
  Widget build(BuildContext context) {
    Log.d("======ChildState======== build ================");

    /// 使用上层组件中共享的数据
    //  int count = ShareDataWidget.of(context)?.clickCount ?? -1;
    return Text(
      "你好哇:",
      style: TextStyle(color: skin().textColor1()),
    );
  }

  /// 是否触发 和 key相关 和是否依赖InheritedWidget相关
  @override
  void didChangeDependencies() {
    Log.d("=======ChildState======= didChangeDependencies ================");
    super.didChangeDependencies();
  }
}

class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({
    super.key,
    required this.clickCount,
    required Widget child,
  }) : super(child: child);

  final int clickCount; //需要在子树中共享的数据，保存点击次数

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget old) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return old.clickCount != clickCount;
  }
}
