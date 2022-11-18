import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// 1. 有名路由 注册 Bindings 子类对象， Bindings 子类注册 GetxController实例.
/// 2. 页面类继承 GetView<GetxController子类> 把 GetxController 子类实例注册到页面类中，以直接使用注册的 GetxController 子类对象：controller

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => const Home(), binding: HomeBinding()),
    ],
  ));
}

class Home extends GetView<Controller> {
  const Home({super.key});

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(title: const Text("counter")),
      body: Center(
        child: Obx(() => Text("${controller.counter}")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ));
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {
  var count = 0.obs;

  void increment() => count++;
}

class Controller extends GetxController {
  var counter = 0.obs;

  void increment() {
    counter++;
    update();
  }
}
