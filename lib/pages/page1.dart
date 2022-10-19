import 'package:flutter/material.dart';

///Navigator.of(context).pushNamed("/page2"); 这种方式跳转页面是整个页面的跳转

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<StatefulWidget> createState() {
    return Page1State();
  }
}

class Page1State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("首页"),
        ),
        backgroundColor: const Color.fromARGB(255, 103, 204, 248),
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
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/page999");
              },
              child: const Text("去页面999"),
            ),
          ],
        ));
  }
}
