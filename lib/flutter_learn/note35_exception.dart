import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_flutter_lib_3/util/execute_timer.dart';
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
                ExeTimer timer = ExeTimer();
                Future.delayed(const Duration(milliseconds: 2000), () {});
                await Future.delayed(const Duration(milliseconds: 2000));
                timer.printExeTime();
              }),
          CupertinoButton(
              child: const Text("flutter UI渲染异常1"),
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
          CupertinoButton(
              child: const Text("flutter UI渲染异常2"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      List? list = null;
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(color: Colors.red),
                          child: Stack(
                            children: [
                              const Positioned(
                                top: 0,
                                child: Text(
                                  "data",
                                  style: TextStyle(color: Color(0xffffffff)),
                                ),
                              ),
                              //   if(list!.length == 1) const SizedBox(),
                              Obx(() => const SizedBox()),
                            ],
                          ),
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
