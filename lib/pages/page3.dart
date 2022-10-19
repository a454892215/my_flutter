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
          title: const Text("页面三"),
        ),
        backgroundColor: const Color.fromARGB(255, 195, 239, 122),
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
