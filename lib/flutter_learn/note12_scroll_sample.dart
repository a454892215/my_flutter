import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/ui_utils.dart';
import 'package:provider/provider.dart';

class SingleChildScrollViewSamplePage extends StatefulWidget {
  const SingleChildScrollViewSamplePage({super.key});

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
      appBar: AppBar(title: const Text("SingleChildScrollViewSamplePage-示例")),
      // FractionallySizedBox 的 widthFactor 生效
      body: Container(
        color: const Color.fromARGB(222, 213, 213, 213),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            buildContainer1(),
            UIUtil.getEmptyBoxByHeight(12),
            buildContainer2(),
          ],
        ),
      ),
    );
  }

  Container buildContainer1() {
    return Container(
      color: Colors.orange,
      height: 220,
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: SingleChildScrollView(
        /// 设置滑动方向，上下/左右
        scrollDirection: Axis.vertical,
        reverse: false,

        /// 滑动反弹效果： BouncingScrollPhysics()
        /// 无滑动反弹效果： ClampingScrollPhysics()
        /// 禁止滑动： NeverScrollableScrollPhysics()
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer2() {
    return Container(
      color: Colors.orange,
      height: 160,
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: false,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Row(
          children: [
            Container(
              width: 100,
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            Container(
              width: 100,
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            Container(
              width: 100,
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            Container(
              width: 100,
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            Container(
              width: 100,
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _MyValuesNotifier extends ChangeNotifier {}
