import 'package:get/get.dart';
import 'package:flutter/material.dart';

String summary = '''
GetView 使用示例：               
  1. 有名路由 注册 Bindings 子类对象， Bindings 子类注册 GetxController实例.
  2. 页面类继承 GetView<GetxController子类> 把 GetxController 子类实例注册到页面类中，以直接使用注册的 GetxController 子类对象：controller
''';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      /// 1. 注册 Bindings
      GetPage(name: '/home', page: () => const Home(), binding: HomeBinding()),
    ],
  ));
}

/// 2. 页面绑定GetxController子类， 注册其示例对象
class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(title: const Text("GetView 使用示例")),
      body: Center(
        /// 3. 使用 controller 数据 更新UI 对象
        child: Obx(() => Text("${controller.counter}")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ));
}

/// 2-01. 创建 Bindings类 子类
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

/// 2-02. 创建 GetxController类 子类
class HomeController extends GetxController {
  var counter = 0.obs;

  void increment() => counter++;
}

