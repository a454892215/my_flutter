import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/ui_utils.dart';
import 'package:provider/provider.dart';

/// 1. FractionallySizedBox 的 widthFactor heightFactor 生效 可以在最外层填充父控件
/// 2. Expanded 控件 通过flex设置权重 定义控件在Column种的高度
/// 3. 怎么在外层高度明确情况下，自己高度包裹内容？？？ 答案：外面包一层无高度的控件，如-Align
class LinearLayoutSamplePage extends StatefulWidget {
  const LinearLayoutSamplePage({super.key});

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
      appBar: AppBar(title: const Text("线性布局-示例")),
      // FractionallySizedBox 的 widthFactor 生效
      body: FractionallySizedBox(
        alignment: Alignment.topCenter,
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
          color: Colors.grey,
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                buildContainer1(),
                buildContainer2(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildContainer1() {
    return Container(
      /// 1.自己不设置高度: 如果外层控件高度确定或者匹配父窗口，则自己也和外层高度相同(自己设置高度也无效)
      /// 2. 怎么在外层高度明确情况下，自己高度包裹内容？？？ 答案：外面包一层无高度的控件，如-Align
      color: Colors.blue,

      /// 只对直接子控件有效
      // alignment:Alignment.center,
      child: Column(
        ///  mainAxisSize: MainAxisSize.min 主轴方向大小包裹内容
        ///  主轴方向的高度决定类型
        mainAxisSize: MainAxisSize.min,

        /// 主轴方向
        mainAxisAlignment: MainAxisAlignment.start,

        /// 次轴方向
        // crossAxisAlignment: CrossAxisAlignment.start,
        /// 文本方向设置
        //  textDirection: TextDirection.ltr,
        children: [
          Container(
            color: Colors.yellow,
            height: 20,
            margin: const EdgeInsets.all(8),
          ),
          Container(
            color: Colors.yellow,
            height: 30,
            margin: const EdgeInsets.all(8),
          ),
          Container(
            color: Colors.yellow,
            height: 40,
            margin: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }

  Container buildContainer2() {
    return Container(
      color: Colors.blue,
      height: 120,
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          ///  Expanded 通过flex设置权重 定义控件在Column种的高度
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.yellow,
              height: 20,
              margin: const EdgeInsets.only(top: 8),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.yellow,
              height: 20,
              margin: const EdgeInsets.only(top: 8),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.yellow,
              height: 20,
              margin: const EdgeInsets.only(top: 8),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
