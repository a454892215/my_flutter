import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/Log.dart';

class ObxNestTestWidget extends StatefulWidget {
  const ObxNestTestWidget({Key? key}) : super(key: key);

  @override
  ObxNestTestWidgetState createState() => ObxNestTestWidgetState();
}

class ObxNestTestWidgetState extends State<ObxNestTestWidget> {
  final btn1 = 1.obs;
  final btn2 = 1.obs;
  final btn3 = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Obx(() => Column(
            children: [
              CupertinoButton(
                  child: Text("第1层按钮：$btn1"),
                  onPressed: () {
                    btn1.value++;
                  }),
              Builder(builder: (c) {
                Log.d("第1层widget被构建");
                return const SizedBox();
              }),
              Obx(() => Column(
                    children: [
                      CupertinoButton(
                          child: Text("第2层按钮：$btn2"),
                          onPressed: () {
                            btn2.value++;
                          }),
                      Builder(builder: (c) {
                        Log.d("第2层widget被构建");
                        return const SizedBox();
                      }),
                      Obx(() => Column(
                            children: [
                              CupertinoButton(
                                  child: Text("第3层按钮：$btn3"),
                                  onPressed: () {
                                    btn3.value++;
                                  }),
                              Builder(builder: (c) {
                                Log.d("第3层widget被构建");
                                return const SizedBox();
                              }),
                            ],
                          )),
                    ],
                  )),
            ],
          )),
    );
  }
}
