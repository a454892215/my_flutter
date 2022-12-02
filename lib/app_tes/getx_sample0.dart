import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../util/Log.dart';

String summary = '''
Getx 的 Obx 使用示例
''';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => const _First()),
    ],
  ));
}

class _First extends StatefulWidget {
  const _First();

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State {
  List<String> names = ["按钮A", "按钮B", "按钮C", "按钮D"];

  var clickedTimes_1 = 0.obs;
  var clickedTimes_2 = 0.obs;
  var clickedTimes_21 = 0.obs;
  var clickedTimes_22 = 0.obs;

  var clickedTimes_3 = 0.obs;
  var student = Student(0.obs, 12.obs, "apple".obs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Getx 基本示例")),
        body: ListView(
          children: [
            MaterialButton(
              onPressed: () {
                clickedTimes_1++;
              },

              ///1. 简单的 Obx 使用示例
              child: Obx(() {
                // Toast.show("==== $clickedTimes ===");
                Log.d("=====按钮1===$clickedTimes_1====");
                return Text(names[clickedTimes_1.value % names.length]);
              }),
            ),
            MaterialButton(
              onPressed: () {
                clickedTimes_2++;
                if (clickedTimes_2 % 2 == 0) {
                  clickedTimes_21++;
                } else {
                  clickedTimes_22++;
                }
              },

              /// 1.Obx 回调函数的作用域必须要有observable variables ，否则报错
              /// 2. 当回调函数作用域的observable variables变化时候，会重新执行此回调函数
              /// 3. Obx 回调函数的作用域可以存在多个observable variables， 当任何一个变化的时候，即触发回调...
              child: Obx(() {
                Log.d("=====按钮2====$clickedTimes_21====$clickedTimes_22=");
                return const Text("按钮2");
              }),
            ),
            MaterialButton(
              onPressed: () {
                clickedTimes_3++;
                if (clickedTimes_3 % 2 == 0) {
                  student.age++;
                } else {
                  student.size++;
                }
                //var listenVar = "=====按钮3==点击==${student.value.age}===${student.value.size}==";
               // Log.d(listenVar);
              },
              // 监听对象的属性发生变化更新UI
              child: Obx(() {
                var listenVar = "==按钮3==${student.age}====${student.size}==";
                Log.d(listenVar);
                return  Text(listenVar.toString());
              }),
            ),
          ],
        ));
  }
}

class Student {
  var size = 0.obs;
  var age= 0.obs;
  var favorite = ''.obs;

  Student(this.size, this.age, this.favorite);
}
