import 'package:flutter/material.dart';
import '../my_widgets/comm_widgets.dart';
import '../util/Log.dart';

///Navigator.of(context).pushNamed("/page2"); 这种方式跳转页面是整个页面的跳转

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return Page2State();
  }
}

class Page2State extends State {
  bool isDebug = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("API用例大全-debug:${Log.isDebugMode()}"),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 217, 216, 216),
        body: Align(
            alignment: Alignment.topCenter,
            child: ListView(
              shrinkWrap: true,
              children: const <RouterButton>[
                RouterButton(params: ["/SystemApiSampleListPage", "api用例1"]),
                RouterButton(params: ["/LibApiSamplesPage", "api用例2"]),
              ],
            )));
  }
}
