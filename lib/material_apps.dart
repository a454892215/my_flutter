import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/flutter_learn/note16_custom_scroll_sample2.dart';
import 'package:my_flutter_lib_3/pages/button_sample_page.dart';
import 'package:my_flutter_lib_3/pages/err_page.dart';
import 'package:my_flutter_lib_3/pages/page1.dart';
import 'package:my_flutter_lib_3/pages/page2.dart';
import 'package:my_flutter_lib_3/pages/page3.dart';

import 'flutter_learn/chexobx_radio_sample.dart';
import 'flutter_learn/form_sample.dart';
import 'flutter_learn/note10_container_sample.dart';
import 'flutter_learn/note11_linear_layout_sample.dart';
import 'flutter_learn/note12_scroll_sample.dart';
import 'flutter_learn/note13_nested_scroll_sample.dart';
import 'flutter_learn/note14_nested_scroll_sample2.dart';
import 'flutter_learn/note15_custom_scroll_sample.dart';
import 'flutter_learn/page_indicaotr_sample.dart';
import 'flutter_learn/provider_sample.dart';
import 'flutter_learn/scaffold_sample.dart';
import 'flutter_learn/text_field_sample.dart';
import 'flutter_learn/text_sample.dart';
import 'navigator/observer.dart';

//默认配置下： 只有此目录下文件名字为main的dart文件的main函数才能正常启动flutter material开发环境？
void main() {
  runApp(getMaterialApp("MaterialApp2"));
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
    debugShowCheckedModeBanner: false,
    /// title 只对Android生效，ios种，任务视图名称取的是 Info.pList 文件中的CFBundleDisplayName或CFBundleName
    title: title,

    /// 1. 定制一个页面的主题样式：可以定制一个主题中每个控件的颜色
    /// 2. ThemeData 是 MaterialDesign Widget种的主题数据， Material种的Widget需要遵循相应的设计规范
    /// 3. 次设计规范能自定义部分都在ThemeData, 故通过ThemeData来自定义Material主题样式
    /// 4. Theme.of方法可以获取当前的 ThemeData，MaterialDesign种有些样式不能自定义，比如导航栏高度
    theme: appThemeData,

    /// routes 路由配置：对象是Map<String, WidgetBuilder>
    routes: {
      '/': (BuildContext context) => const Page1(),
      '/page1': (BuildContext context) => const Page1(),
      '/page2': (BuildContext context) => const Page2(),
      '/page3': (BuildContext context) => const Page3(),
      '/ButtonSamplePage': (BuildContext context) => const ButtonSamplePage(),
      '/TabIndicatorSamplePage': (BuildContext context) => const TabIndicatorSamplePage(),
      '/ScaffoldSamplePage': (BuildContext context) => const ScaffoldSamplePage(),
      '/ProviderSamplePage': (BuildContext context) => const ProviderSamplePage(),
      '/TextSamplePage': (BuildContext context) => const TextSamplePage(),
      '/TextFieldSamplePage': (BuildContext context) => const TextFieldSamplePage(),
      '/FormSamplePage': (BuildContext context) => const FormSamplePage(),
      '/ContainerSamplePage': (BuildContext context) => const ContainerSamplePage(),
      '/LinearLayoutSamplePage': (BuildContext context) => const LinearLayoutSamplePage(),
      '/SingleChildScrollViewSamplePage': (BuildContext context) => const SingleChildScrollViewSamplePage(),
      '/NestedScrollViewSamplePage': (BuildContext context) => const NestedScrollViewSamplePage(),
      '/NestedScrollViewSamplePage2': (BuildContext context) => const NestedScrollViewSamplePage2(),
      '/CustomScrollViewSamplePage': (BuildContext context) => const CustomScrollViewSamplePage(),
      '/CustomScrollViewSample2Page': (BuildContext context) => const CustomScrollViewSample2Page(),
      '/CheckboxSamplePage': (BuildContext context) => const CheckboxSamplePage(),
    },

    /// 配置404页面: 如果路由不存在则跳到该页面
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(builder: (BuildContext context) => const ErrPage());
    },

    /// 配置页面离开和进入的监听
    navigatorObservers: [MyNavigatorObserver()],

    /// 与 routes 中的 / 效果基本一致， 指定应用的第一个显示页面
    ///   initialRoute: '/page1',
    /// home 与 routes配置的 / 互斥 同时配置会抛异常
    ///  home: const Page1()
  );
}

/// ============== Theme 配置 ===============
ThemeData appThemeData = ThemeData(
  /// primarySwatch 用于导航栏和floatActionButton的背景色等
  primarySwatch: Colors.blue,

  /// brightness 应用程序亮色或者暗色, 会调整导航栏和页面的背景色(如果不显示设置)
  brightness: Brightness.light,

  /// 配置主背景色
  primaryColor: Colors.red,

  /// 设置 appBarTheme， 颜色如果没有指定取 primarySwatch
  appBarTheme: appBarTheme,

  /// 设置 app 中所有icon 颜色样式
  iconTheme: const IconThemeData(color: Colors.amber, size: 28, opacity: 0.86),

  /// 设置 app 中所有icon 颜色样式: 如果appBarTheme 没有设置，默认取此， 与 primaryColor形成对比的图标主题
  primaryIconTheme: const IconThemeData(color: Colors.orange, size: 28, opacity: 0.86),

  ///  设置button 点击效果
 // highlightColor: Colors.transparent,

 //  splashColor: Colors.red,

  buttonTheme: buttonTheme,

  /// 设置button 的 theme
  textButtonTheme: textButtonTheme,
);

///  ============== AppBarTheme 配置 ===============
AppBarTheme appBarTheme = const AppBarTheme(
  ///  配置app bar 图标颜色
  color: Color.fromARGB(255, 50, 197, 40),

  /// 设置阴影显示
  elevation: 20,

  /// 设置app bar 中的icon 颜色 大小, 不透明度
  iconTheme: IconThemeData(color: Color.fromARGB(222, 255, 255, 255), size: 28, opacity: 1),

  ///  配置app bar 右侧图标样式
  actionsIconTheme: IconThemeData(color: Colors.white, size: 28, opacity: 1),
);

/// ============== ButtonTheme 配置 ===============
ButtonThemeData buttonTheme = const ButtonThemeData(
  textTheme: ButtonTextTheme.normal,

  /// 点击高亮时候的颜色   --无效？
  highlightColor: Colors.purple,

  /// 不可以点击时候的颜色
  disabledColor: Colors.grey,

  buttonColor: Colors.green,

  /// 无效 ？
  splashColor: Colors.amberAccent,

  /// 鼠标悬停颜色 无效 ？
  hoverColor: Colors.amberAccent,

  /// 获取焦点颜色 无效 ？
  focusColor: Colors.black26,
);

/// ============== TextButtonTheme 配置 ===============
TextButtonThemeData textButtonTheme = const TextButtonThemeData(
  style: ButtonStyle(
      //  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(99, 152, 203, 82)),
      splashFactory: NoSplash.splashFactory // 为什么无效？
      ),
);

/// 5. MaterialApp种配置默认页面的三种方式，1.home  2.initialRoute(需要和routes配合使用)， 3. routes种的/
