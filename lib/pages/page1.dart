import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

///Navigator.of(context).pushNamed("/page2"); 这种方式跳转页面是整个页面的跳转
/// 1. StatelessWidget 无动态变化属性的页面
/// 2. StatefulWidget 动态变化属性的页面
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
          title: const Icon(Icons.account_circle),
          iconTheme: const IconThemeData(color: Colors.blue),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Toast.toast("你好啊");
          },
        ),
        // backgroundColor: const Color.fromARGB(255, 103, 204, 248),
        body: Row(
          children: [
            const Icon(Icons.account_circle),
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
                Navigator.of(context).pushNamed("/ButtonSamplePage");
              },
              child: const Text("按钮示例页面"),
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
