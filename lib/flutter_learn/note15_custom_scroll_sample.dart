import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomScrollViewSamplePage extends StatefulWidget {
  const CustomScrollViewSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _MyValuesNotifier()),
      ],
      child: buildScaffold(tabController),
    );
  }

  Scaffold buildScaffold(TabController tabController) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CustomScroll-示例"),
        backgroundColor: Colors.pink,
      ),
      body: CustomScrollView(),
    );
  }

  ListView buildListView1() {
    return ListView.builder(
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
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
