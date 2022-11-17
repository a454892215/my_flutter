import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

String summary = ''' 
1. TextButton
2. ElevatedButton            
3. OutlinedButton
4. MaterialButton
''';
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
              //1.按钮按下回调value=true，2.按钮抬起回调value=false
              onHighlightChanged: (value){},
              textColor: Colors.white,
              color: Colors.blue,
              // 按下时候的颜色
              highlightColor: Colors.lightBlueAccent,
              // 不能点击时候的阴影高度
              disabledElevation: 5,
              //shape: Border.all(color: Colors.pink, width: 2),
              //shape: const Border(bottom: BorderSide(color: Colors.pink, width: 2)),
              //设置底部边框
              // shape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink, width: 2)),
              // 圆角矩形边框
              shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.pink, width: 2)),
              // 圆形边框
              //shape: const CircleBorder(side: BorderSide(color: Colors.pink, width: 2)),
              child: const Text("MaterialButton"),
            ),
          ],
        ),
      ),
    );
  }
}
