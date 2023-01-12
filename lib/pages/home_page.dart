import 'package:flutter/material.dart';
import '../my_widgets/comm_widgets.dart';

///Navigator.of(context).pushNamed("/page2"); 这种方式跳转页面是整个页面的跳转

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return Page2State();
  }
}

class Page2State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("API用例大全"),),
        ),
        backgroundColor: const Color.fromARGB(255, 217, 216, 216),
        body: Align(
            alignment: Alignment.topCenter,
            child: ListView(
              shrinkWrap: true,
              children: const <RouterButton>[
                RouterButton(params: ["/SystemApiSampleListPage", "系统api用例"]),
                RouterButton(params: ["/LibApiSamplesPage", "第三方库api用例"]),
              ],
            )));
  }
}
