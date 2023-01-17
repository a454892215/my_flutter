import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              child: const Text("flutter 空指针异常"),
              onPressed: () {
                List? ls;
                toast('length: ${ls!.length}');
              }),
          CupertinoButton(
              child: const Text("flutter 异步异常"),
              onPressed: () async {
                await Future.delayed(const Duration(milliseconds: 1000), () {
                  List? ls;
                  toast('length: ${ls!.length}');
                });
              }),
          CupertinoButton(
              child: const Text("flutter 异步测试"),
              onPressed: () async {
                var start = DateTime.now().microsecondsSinceEpoch;
                Future.delayed(const Duration(milliseconds: 1000), () {});
                var end = DateTime.now().microsecondsSinceEpoch;
                print("LLpp 结束请求数据....cost time:${end- start}");
              }),
          CupertinoButton(
              child: const Text("flutter UI渲染异常"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.green,
                          decoration: const BoxDecoration(color: Colors.red),
                        ),
                      );
                    });
              }),
        ],
      ),
    ));
  }

  static Future<void> exe() async {}
}
