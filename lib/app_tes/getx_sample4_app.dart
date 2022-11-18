import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';
import 'package:get/get.dart';

String summary = '''
''';

void main() {
  runApp(const GetMaterialApp(
    title: "MaterialApp",
    home: _Page(),
  ));
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("getx 4"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Toast.show("FloatingActionButton");
        },
        child: const Text("按钮"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(width: 120, height: 120, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

class GetXSampleCode {
  /// 有3种声明方式： 1、使用 Rx{Type} 建议使用初始值，但不是强制性的 ...
  void test() {
    final name = RxString('');
    final isLogged = RxBool(false);
    final count = RxInt(0);
    final balance = RxDouble(0.0);
    final items = RxList<String>([]);
    final myMap = RxMap<String, int>({});
  }

  /// 2. 使用 Rx，规定泛型 Rx
  void test2() {
    final name = Rx<String>('');
    final isLogged = Rx<bool>(false);
    final count = Rx<int>(0);
    final balance = Rx<double>(0.0);
    final number = Rx<num>(0);
    final items = Rx<List<String>>([]);
    final myMap = Rx<Map<String, int>>({});
    // 自定义类 - 可以是任何类
    final user = Rx<Object>(Object());
  }

  /// 3. 这种更实用、更简单、更可取的方法，只需添加 .obs 作为value的属性。（推荐使用）
  void test3() {
    final name = ''.obs;
    final isLogged = false.obs;
    final count = 0.obs;
    final balance = 0.0.obs;
    final number = 0.obs;
    final items = <String>[].obs;
    final myMap = <String, int>{}.obs;
    // 自定义类 - 可以是任何类
    final user = Object().obs;
  }

}
