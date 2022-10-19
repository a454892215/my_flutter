import 'package:flutter/material.dart';

///Navigator.of(context).pushNamed("/page2"); 这种方式跳转页面是整个页面的跳转

class Page2 extends StatefulWidget {
  const Page2({super.key});

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
          title: const Text("页面二"),
        ),
        backgroundColor: const Color.fromARGB(222, 255, 109, 109),
        body: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/page1");
              },
              child: const Text("去首页"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/page2");
              },
              child: const Text("去页面2"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/page3");
              },
              child: const Text("去页面3"),
            ),
          ],
        ));
  }
}
