import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

class ButtonSamplePage extends StatelessWidget {
  const ButtonSamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("各种按钮示例"),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ListView(
          children: [
            TextButton(
              onPressed: () => Toast.toast("默认-TextButton"),
              child: const Text("默认-TextButton"),
            ),
            const Padding(padding: EdgeInsets.only(top: 12)),
            ElevatedButton(onPressed: () => Toast.toast("默认-ElevatedButton"), child: const Text("默认-ElevatedButton")),
            const Padding(padding: EdgeInsets.only(top: 12)),
            OutlinedButton(onPressed: () => Toast.toast("默认-OutlinedButton"), child: const Text("默认-OutlinedButton")),
            const Padding(padding: EdgeInsets.only(top: 12)),
            TextButton(
              onPressed: () => Toast.toast("自定义-TextButton"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xffcccccc)),
              ),
              child: const Text("自定义-TextButton"),
            ),
            const Padding(padding: EdgeInsets.only(top: 12)),
            ElevatedButton(onPressed: () => Toast.toast("ElevatedButton"), child: const Text("ElevatedButton2")),
            const Padding(padding: EdgeInsets.only(top: 12)),
            MaterialButton(
              onPressed: () =>Toast.toast("MaterialButton"),
              color: Colors.blue,
              child: const Text("MaterialButton"),
            ),
          ],
        ),
      ),
    );
  }
}
