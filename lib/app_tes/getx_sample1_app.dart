import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../util/Log.dart';

String summary = '''
Getx 的 GetPage， Bindings， GetxController使用示例：               
  1. 有名路由注册Bindings子类对象,  Bindings 子类注册多个 GetxController 示例
  2. 无名路由绑定 Bindings 跳转页面 示例  
''';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => _Page(), binding: SampleBind()),
    ],
  ));
}

class _Page extends StatelessWidget {
  /// 1. 已经在路由中绑定类Controller3，所以直接通过Controller3获取该对象即可
  final controller = Get.find<Controller3>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Second Page"),
        ),
        body: ListView(
          children: [
            GetBuilder<Controller3>(builder: (controller) {
              Log.d("========GetBuilder========");
              return MaterialButton(
                onPressed: () {
                  controller.increment();
                },
                child: Text("按钮---${controller.count1}"),
              );
            })
          ],
        ));
  }
}

/// 1. Bindings 注册 GetxController 用例
class SampleBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller3>(() => Controller3());
  }
}

class Controller3 extends GetxController {
  var count1 = 3;

  void increment() {
    count1++;
    update();
  }
}
