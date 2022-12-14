import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../my_widgets/comm_text_widget.dart';

String summary = '''
GetX 综合用例
1. "title".trArgs(['John']) 字符串 title 的国际化示例
2. GetBuilder 构建 GetxController widget 示例
3. Get路由跳转示例: Get.toNamed('/second');
4. 本地语言切换示例: Get.updateLocale(const Locale('en', 'UK'));
5. GetView<> 使用示例
''';

void main() {
  runApp(GetMaterialApp(
    // It is not mandatory to use named routes, but dynamic urls are interesting.
    initialRoute: '/home',
    defaultTransition: Transition.native,
    translations: MyTranslations(),
    locale: const Locale('zh', 'CH'),
    getPages: [
      //Simple GetPage
      GetPage(name: '/home', page: () => const First()),
      // GetPage with custom transitions and bindings
      GetPage(
        name: '/second',
        page: () => const Second(),
        customTransition: SizeTransitions(),
        binding: SampleBind(),
      ),
      // GetPage with default transitions
      GetPage(
        name: '/third',
        transition: Transition.cupertino,
        page: () => const Third(),
      ),
    ],
  ));
}

class Controller extends GetxController {
  int count = 0;

  void increment() {
    count++;
    // use update method to update all count variables
    update();
  }
}

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Get.snackbar("标题", "getx 的 snackbar 示例 ",
                duration: const Duration(seconds: 1));
          },
        ),

        /// 1. 字符串 title 的国际化示例
        title: Text("title".trArgs(['John'])),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 2. GetBuilder 构建 GetxController widget 示例
            GetBuilder<Controller>(
              init: Controller(),
              // You can initialize your controller here the first time. Don't use init in your other GetBuilders of same controller
              builder: (_) => CommButton(
                  onPressed: () => Get.find<Controller>().increment(),
                  text: 'clicks: ${_.count}'),
            ),
            ElevatedButton(
              child: const Text('to second page'),
              onPressed: () {
                /// 3. Get路由跳转示例
                Get.toNamed('/second');
              },
            ),
            ElevatedButton(
              child: const Text('切换到英语'),
              onPressed: () {
                ///4.  本地语言切换示例
                Get.updateLocale(const Locale('en', 'UK'));
              },
            ),
            ElevatedButton(
              child: const Text('切换到中文'),
              onPressed: () {
                Get.updateLocale(const Locale('zh', 'CH'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 5. GetView<> 使用示例
class Second extends GetView<ControllerX> {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () {
                return Text('count1：${controller.count1}');
              },
            ),
            Obx(
              () {
                return Text('count2： ${controller.count2}');
              },
            ),
            Obx(() {
              return Text('sum：${controller.sum}');
            }),
            Obx(
              () => Text('Name: ${controller.user.value.name}'),
            ),
            Obx(
              () => Text('Age: ${controller.user.value.age}'),
            ),
            ElevatedButton(
              child: const Text("Go to last page"),
              onPressed: () {
                Get.toNamed('/third', arguments: 'arguments of second');
              },
            ),
            ElevatedButton(
              child: const Text("Back page and open snackbar"),
              onPressed: () {
                Get.back();
                Get.snackbar(
                  'User 123',
                  'Successfully created',
                );
              },
            ),
            ElevatedButton(
              child: const Text("Increment"),
              onPressed: () {
                controller.increment();
              },
            ),
            ElevatedButton(
              child: const Text("Increment"),
              onPressed: () {
                controller.increment2();
              },
            ),
            ElevatedButton(
              child: const Text("Update name"),
              onPressed: () {
                controller.updateUser();
              },
            ),
            ElevatedButton(
              child: const Text("Dispose worker"),
              onPressed: () {
                controller.disposeWorker();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Third extends GetView<ControllerX> {
  const Third({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        controller.incrementList();
      }),
      appBar: AppBar(
        title: Text("Third ${Get.arguments}"),
      ),
      body: Center(
          child: Obx(() => ListView.builder(
              itemCount: controller.list.length,
              itemBuilder: (context, index) {
                return Text("${controller.list[index]}");
              }))),
    );
  }
}

class SampleBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerX>(() => ControllerX());
  }
}

class User {
  User({this.name = 'Name', this.age = 0});

  String name;
  int age;
}

class ControllerX extends GetxController {
  final count1 = 0.obs;
  final count2 = 0.obs;
  final list = [56].obs;
  final user = User().obs;

  updateUser() {
    user.update((value) {
      value!.name = 'Jose';
      value.age = 30;
    });
  }

  /// Once the controller has entered memory, onInit will be called.
  /// It is preferable to use onInit instead of class constructors or initState method.
  /// Use onInit to trigger initial events like API searches, listeners registration
  /// or Workers registration.
  /// Workers are event handlers, they do not modify the final result,
  /// but it allows you to listen to an event and trigger customized actions.
  /// Here is an outline of how you can use them:

  /// made this if you need cancel you worker
  late Worker _ever;

  @override
  onInit() {
    super.onInit();

    /// Called every time the variable $_ is changed
    _ever = ever(count1, (_) => print("$_ has been changed (ever)"));

    everAll([count1, count2], (_) => print("$_ has been changed (everAll)"));

    /// Called first time the variable $_ is changed
    once(count1, (_) => print("$_ was changed once (once)"));

    /// Anti DDos - Called every time the user stops typing for 1 second, for example.
    debounce(count1, (_) => print("debouce$_ (debounce)"),
        time: const Duration(seconds: 1));

    /// Ignore all changes within 1 second.
    interval(count1, (_) => print("interval $_ (interval)"),
        time: const Duration(seconds: 1));
  }

  ///
  int get sum => count1.value + count2.value;

  increment() => count1.value++;

  increment2() => count2.value++;

  disposeWorker() {
    _ever.dispose();
    // or _ever();
  }

  incrementList() => list.add(75);
}

class SizeTransitions extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return Align(
      alignment: Alignment.center,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animation,
          curve: curve!,
        ),
        child: child,
      ),
    );
  }
}

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'title': 'Hello World %s',
        },
        'en_US': {
          'title': 'Hello World from US',
        },
        'pt': {
          'title': 'Olá de Portugal',
        },
        'pt_BR': {
          'title': 'Olá do Brasil',
        },
        'zh': {
          'title': '你好世界 %s',
        },
        'zh_CH': {
          'title': '你好世界 %s',
        },
      };
}
