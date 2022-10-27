import 'package:flutter/material.dart';

import '../../util/Log.dart';

main() {
  runApp(const MaterialApp(
    title: "WillPopScopeSamplePage",
    home: WillPopScopeSamplePage(),
  ));
}

class WillPopScopeSamplePage extends StatefulWidget {
  const WillPopScopeSamplePage({Key? key}) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State {
  int _lastClickBackTime =  0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WillPopScope-Sample"),
      ),
      body: GestureDetector(
        onTap: () {},
        child: WillPopScope(
          onWillPop: () async {
            int nowTime = DateTime.now().millisecondsSinceEpoch; // millisecondsSinceEpoch为时间戳
            int dTime = nowTime - _lastClickBackTime ;
            _lastClickBackTime = nowTime;
            Log.d("dTime:$dTime  nowTime:$nowTime");
            if (dTime > 1000) {
              return false;
            }
            return showTips();
          },
          child: const Text("WillPopScope-test"),
        ),
      ),
    );
  }

  Future<bool> showTips() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("提示"),
            content: const Text("确定要退出吗？"),
            actions: [
              TextButton(onPressed: () {}, child: const Text("确定")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("取消")),
            ],
          );
        });
    return false;
  }

}
