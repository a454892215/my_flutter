import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: ExceptionTestPage(),
  ));
}

class ExceptionTestPage extends StatefulWidget {
  const ExceptionTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ExceptionTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          Container(
            color: Colors.green,
            height: 150.w,
            alignment: Alignment.center,
            child: const Text("异常处理测试"),
          ),
          CupertinoButton(
              child: const Text("flutter 计算异常"),
              onPressed: () {
                double a = 10 / 0; // flutter 中除以0 不会报异常
                toast("a:$a");
              }),
          CupertinoButton(
              child: const Text("flutter 空指针异常"),
              onPressed: () {
                List? ls;
                toast('length: ${ls!.length}');
              }),
          CupertinoButton(
              child: const Text("flutter UI渲染异常"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 200,
                            height: 200,
                            color: Colors.green,
                            decoration: const BoxDecoration(color: Colors.red),
                          ),
                        ),
                      );
                    });
              }),
        ],
      ),
    ));
  }
}
