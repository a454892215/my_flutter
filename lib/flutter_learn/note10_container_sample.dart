import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/ui_utils.dart';
import 'package:provider/provider.dart';

class ContainerSamplePage extends StatefulWidget {
  const ContainerSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _MyValuesNotifier()),
      ],
      child: buildScaffold(),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: AppBar(title: const Text("Container-示例")),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            /// Container的最终宽高是按照：外层父控件宽高->自己设置的宽高->内部子控件宽高 的次序决定的：
            /// 1.如果外层父控件设置了宽高，则自己的宽高取外层父控件宽高（自己设置了也无用）
            /// 2.如果外层父控件没有设置了宽高，则先看自己是否设置了宽高，如果自己设置了，则取自己宽高，如果没有，则取子控件的宽高.
            /// 问题，如果外层Container需要设置宽高，内层Container也需要设置宽高怎么办？
            /// 答：通过 父控件 padding 与子控件 margin 以缩小子控件宽高, 设置子控件在父控件中的相对位置. 如果有多个子控件则必然有中间容器就另当别论了.
            buildContainer1(),
            UIUtil.getEmptyBoxByHeight(10),
            buildContainer2(),
            UIUtil.getEmptyBoxByHeight(10),
            buildContainer3(),
            UIUtil.getEmptyBoxByHeight(10),
            buildContainer4(),
            UIUtil.getEmptyBoxByHeight(10),
            buildContainer5(),
            UIUtil.getEmptyBoxByHeight(10),
            buildContainer6(),
          ],
        ),
      ),
    );
  }

  Container buildContainer1() {
    return Container(
      width: 60,
      height: 60,
      color: Colors.blue,
      child: Container(
        color: Colors.grey,
        child: const Text("我是文本"),
      ),
    );
  }

  Container buildContainer2() {
    return Container(
      width: 140,
      height: 140,
      padding: const EdgeInsets.all(20),
      color: Colors.blue,
      child: Container(
        width: 60,
        height: 60,
        color: Colors.grey,
        child: const Text("我是文本"),
      ),
    );
  }

  /// 如果内外Container不是连续的，则不生效
  Container buildContainer3() {
    return Container(
      width: 280,
      height: 120,
      padding: const EdgeInsets.all(20),
      color: Colors.blue,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            color: Colors.grey,
            child: const Text("我是文本"),
          ),
          Container(
            width: 40,
            height: 40,
            color: Colors.grey,
            margin: const EdgeInsets.all(5),
            child: const Text("我是文本"),
          ),
          Container(
            width: 40,
            height: 40,
            color: Colors.grey,
            margin: const EdgeInsets.all(5),
            child: const Text("我是文本"),
          ),
        ],
      ),
    );
  }

  // Container 的 decoration 测试
  Container buildContainer4() {
    return Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(20),
      alignment: const Alignment(0, 0),
      // 内容居中

      /// color: Colors.blue, color和decoration只能设置一个，否则报错
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.red, width: 2, style: BorderStyle.solid),

        /// 1. all设置圆角
        // borderRadius: const BorderRadius.all(Radius.circular(8)),
        /// 2.horizontal 设置圆角 elliptical(): 两个参数表示水平方向和垂直方向的各自圆角
        //borderRadius: const BorderRadius.horizontal(left: Radius.elliptical(8, 16), right: Radius.circular(8)),

        /// 3. only 设置圆角
        //borderRadius: const BorderRadius.only(topLeft: Radius.circular(8))),
        // 设置box形状：有 circle 和 rectangle 两种。 circle和borderRadius 冲突
        shape: BoxShape.circle,

        /// 设置渐变颜色渲染： 线性渐变，至少2个颜色，否则报错
        gradient: const LinearGradient(colors: [Colors.blue, Colors.white, Colors.green]),
      ),
      child: const Text("我是文本"),
    );
  }

  /// Container 颜色的 环形渐变
  Container buildContainer5() {
    return Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(20),
      alignment: const Alignment(0, 0),
      // 内容居中

      /// color: Colors.blue, color和decoration只能设置一个，否则报错
      decoration: const BoxDecoration(
        shape: BoxShape.circle,

        /// 设置渐变颜色渲染：环形渐变 ，至少2个颜色，否则报错
        gradient: RadialGradient(
          colors: [Colors.blue, Colors.white, Colors.green],
          /// 设置渐变中心点位置
          center: Alignment.center,
          // 设渲染颜色的半径
          radius: 0.5,
          /// 设置填充方式
          tileMode: TileMode.clamp,
        ),
      ),
      child: const Text("我是文本"),
    );
  }


  /// Container 颜色的 扫描渐变
  Container buildContainer6() {
    return Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(20),
      alignment: const Alignment(0, 0),
      // 内容居中

      /// color: Colors.blue, color和decoration只能设置一个，否则报错
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [Colors.blue, Colors.yellow, Colors.green, Colors.red],
        ),
      ),
      child: const Text("我是文本"),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
