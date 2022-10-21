import 'package:flutter/material.dart';

///Navigator.of(context).pushNamed("/page2"); 这种方式跳转页面是整个页面的跳转

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<StatefulWidget> createState() {
    return Page3State();
  }
}

class Page3State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("页面3"),
        ),
        backgroundColor: const Color.fromARGB(222, 255, 109, 109),
        body: const Center(child: Text("页面3")));
  }
}
