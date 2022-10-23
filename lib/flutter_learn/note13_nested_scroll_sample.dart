import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NestedScrollViewSamplePage extends StatefulWidget {
  const NestedScrollViewSamplePage({super.key});

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
              // title: Container(color: Colors.red, child: const Text('复仇者联盟'),),
              leading: const SizedBox(),
              expandedHeight: 240,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  color: Colors.green,
                  width: 160,
                  child: const Text('复仇者联盟'),
                ),
                background: Image.network(
                  'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
          ];
        },
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 12, right: 12),
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
