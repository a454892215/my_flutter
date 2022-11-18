import 'package:get/get.dart';
import 'package:flutter/material.dart';

String summary = '''
Getx 的 GetPage， Bindings， GetxController使用示例：               
  1. 有名路由注册Bindings子类对象,  Bindings 子类注册多个 GetxController 示例
  2. 无名路由绑定 Bindings 跳转页面 示例  
''';


void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => const _First(), binding: SampleBind()),
    ],
  ));
}

class _First extends StatelessWidget {
  const _First();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Getx 的 Bindings 使用示例"),
      ),
      body: ListView(children: [
        MaterialButton(onPressed: () {
          /// 2. 无名路由绑定 Bindings 跳转页面
          Get.to(const _Second(), binding: SampleBind());
        }, child: const Text("to Second Page")),
      ],)
    );
  }
}

class _Second extends StatelessWidget {
  const _Second();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: ListView(children: const [

      ],)
    );
  }
}

/// 1. Bindings 注册多个 GetxController 用例
class SampleBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());
    Get.lazyPut<Controller2>(() => Controller2());
    Get.lazyPut<Controller3>(() => Controller3());
  }
}

class Controller extends GetxController {
  var count1 = 0.obs;

  void increment() {
    count1++;
    update();
  }
}

class Controller2 extends GetxController {
  var count2 = 0.obs;

  void increment() {
    count2++;
    update();
  }
}

class Controller3 extends GetxController {
  var count3 = 0.obs;

  void increment() {
    count3++;
    update();
  }
}
