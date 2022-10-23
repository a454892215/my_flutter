import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NestedScrollViewSamplePage2 extends StatefulWidget {
  const NestedScrollViewSamplePage2({super.key});

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
      appBar: AppBar(title: const Text("NestedScrollView-示例")),
      // FractionallySizedBox 的 widthFactor 生效
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Container(color: Colors.red, child: const Text('复仇者联盟'),),
              leading: const SizedBox(),

              /// SliverAppBar  pinned 表示SliverAppBar/flexibleSpace的title 是否跟着一起滑动到不可见（true 钉住，不滑动到不可见）
              pinned: true,
              //floating 看不出效果？ rue 的时候下滑先展示SliverAppBar，展示完成后才展示其他滑动组件内容
              floating: true,
              expandedHeight: 180,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  color: Colors.green,
                  child: const Text('复仇者联盟'),
                ),
                background: Container(
                    color: Colors.yellow,
                ),
              ),
            )
          ];
        },
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.white,
              //  padding: const EdgeInsets.only(left: 12, right: 12),
              child: Container(
                height: 80,
                color: Colors.primaries[index % Colors.primaries.length],
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            );
          },
          itemCount: 20,
        ),
      ),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
