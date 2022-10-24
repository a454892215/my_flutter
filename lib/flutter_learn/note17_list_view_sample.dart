import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/list_util.dart';

/// 1. 简单的 ListView
class ListViewSamplePage extends StatefulWidget {
  const ListViewSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        title: const Text("简单的-ListView"),
      ),
      body: Container(
        color: Colors.grey,
        child: ListView(
          // size 不包裹内容
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: ListU.fillRange(0, 20)
              .map((e) => Container(
                    height: 60,
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    color: Colors.green,
                    alignment: Alignment.center,
                    child: Text("文本$e"),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
