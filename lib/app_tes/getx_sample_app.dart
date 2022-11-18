import 'package:get/get.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => const First(), binding: SampleBind()),
    ],
  ));
}

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("getX sample"),
      ),
      body: const Center(
        child: Text("getX Sample"),
      ),
    );
  }
}

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
