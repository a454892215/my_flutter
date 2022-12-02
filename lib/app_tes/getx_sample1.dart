import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../util/Log.dart';

String summary = '''
Getx 的 GetBuilder 使用示例
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
  final student = Get.put(StudentController());
  int clickedTimes_1 = 0;
  int clickedTimes_2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Getx 基本示例")),
        body: ListView(
          children: [
            MaterialButton(
              onPressed: () {
                clickedTimes_1++;
                if (clickedTimes_1 % 2 == 0) {
                  student.age.value++;
                } else {
                  student.size++;
                }
                //var listenVar = "=====按钮3==点击==${student.value.age}===${student.value.size}==";
                // Log.d(listenVar);
              },

              /// 1. Obx 使用 GetxController 中的属性，其也必须是RxXX 类型
              child: Obx(() {
                var listenVar = "==按钮1==${student.age}=";
                Log.d(listenVar);
                return Text(listenVar.toString());
              }),
            ),
            GetBuilder<StudentController>(
               id: "id_1", /// 1. 如果定义了ID 则调用update刷新 必须指定ID才能生效.
                builder: (controller) {
                  var listenVar = "==按钮2==${student.appSize}==${student.addSize}=";
                  Log.d(listenVar);
                  return MaterialButton(
                    onPressed: () {
                      clickedTimes_2++;
                      if (clickedTimes_2 % 2 == 0) {
                        student.appSize++;
                      } else {
                        student.addSize++;
                      }
                      student.update(["id_1"]);
                    },
                    child: Text(listenVar),
                  );
                })
          ],
        ));
  }
}

class StudentController extends GetxController {
  int size = 0;
  final age = 0.obs;

  var appSize = 0;
  var addSize = 0;
  String favorite = '';
}
