import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../my_widgets/comm_text_widget.dart';

String summary = '''
1. 通过 Obx() 对象 修改，获取 RxInt类型的变量， 更新UI
2. 通过GetX()对象， 修改, 获取 GetxController对象中的 RxInt变量更新UI
''';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: GetXSamplePage(),
  ));
}

class GetXSamplePage extends StatefulWidget {
  const GetXSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  /// 1-01  使用.obs 初始化变量 获取RxXX 类型的变量
  var count = 0.obs;

  /// 2-02 创建GetxController类的对象， 共享数据
  final controller = Get.put(Controller());

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetXSamplePage"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          //  alignment: Alignment.center,
          children: [
            /// 1-02. 通过 Obx() 对象 修改，获取 RxInt类型的count变量， 更新UI
            Obx(() => CommButton(
                onPressed: () {
                  count++;
                },
                text: "按钮： $count")),

            /// 2-03. 通过GetX()对象，修改, 获取 自定义的GetxController子类对象中的RxInt变量更新UI
            GetX<Controller>(
                builder: (_) => CommButton(
                    text: 'clicks: ${controller.count2}',
                    onPressed: () {
                      controller.increment();
                    })),

            ElevatedButton(
              child: const Text('Next Route'),
              onPressed: () {
                Get.to(_SecondPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 2-01 声明 GetxController 类跨页面共享数据
class Controller extends GetxController {
  var count2 = 0.obs;

  void increment() {
    count2++;
    update();
  }
}

/// 简单的 GetxController 示例 02
class _SecondPage extends StatelessWidget {
  final Controller controller = Get.find();

  _SecondPage();

  @override
  Widget build(context) {
    return Scaffold(body: Center(child: Text("${controller.count2}")));
  }
}
