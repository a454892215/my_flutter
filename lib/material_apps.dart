import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/pages/err_page.dart';
import 'package:my_flutter_lib_3/pages/page1.dart';
import 'package:my_flutter_lib_3/pages/page2.dart';
import 'package:my_flutter_lib_3/pages/page3.dart';

//默认配置下： 只有此目录下文件名字为main的dart文件的main函数才能正常启动flutter material开发环境？
void main() {
  runApp(const MyMaterialApp(title: "MaterialApp2"));
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return getMaterialApp(title);
  }
}

Widget getMaterialApp(var title) {
  return MaterialApp(
      title: title,

      /// 1. 定制一个页面的主题样式：可以定制一个主题中每个控件的颜色
      /// 2. ThemeData 是 MaterialDesign Widget种的主题数据， Material种的Widget需要遵循相应的设计规范
      /// 3. 次设计规范能自定义部分都在ThemeData, 故通过ThemeData来自定义Material主题样式
      /// 4. Theme.of方法可以获取当前的 ThemeData，MaterialDesign种有些样式不能自定义，比如导航栏高度
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      /// routes 路由配置：对象是Map<String, WidgetBuilder>
      routes: {
        // '/': (BuildContext context) => getHome(),
        '/page1': (BuildContext context) => const Page1(),
        '/page2': (BuildContext context) => const Page2(),
        '/page3': (BuildContext context) => const Page3()
      },
      // 配置404页面
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrPage());
      },
      // 与 routes 中的 / 效果基本一致， 指定应用的第一个显示页面
      //   initialRoute: '/page1',
      // home 与 routes配置的 / 互斥 同时配置会抛异常
      home: const Page1());
}

/// 5. MaterialApp种配置默认页面的三种方式，1.home  2.initialRoute(需要和routes配合使用)， 3. routes种的/
