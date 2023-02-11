import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_flutter_lib_3/pages/err_page.dart';
import 'package:my_flutter_lib_3/routers.dart';
import 'package:my_flutter_lib_3/util/Log.dart';
import 'env.dart';
import 'navigator/observer.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Widget getMaterialApp() {
  /// 使用 GetMaterialApp 取代MaterialApp 以方便使用Get.to(_SecondPage()) 导航页面
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    showPerformanceOverlay:true, // CPU/UI性能监控
    enableLog: false,

    /// title 只对Android生效，ios种，任务视图名称取的是 Info.pList 文件中的CFBundleDisplayName或CFBundleName
    title: "app标题",

    /// 1. 定制一个页面的主题样式：可以定制一个主题中每个控件的颜色
    /// 2. ThemeData 是 MaterialDesign Widget种的主题数据， Material种的Widget需要遵循相应的设计规范
    /// 3. 次设计规范能自定义部分都在ThemeData, 故通过ThemeData来自定义Material主题样式
    /// 4. Theme.of方法可以获取当前的 ThemeData，MaterialDesign种有些样式不能自定义，比如导航栏高度
    theme: appThemeData,
    defaultTransition: Transition.rightToLeftWithFade,

    /// routes 路由配置：对象是Map<String, WidgetBuilder>
    // routes: [], 这种方式配置路由，defaultTransition 不能生效
    getPages: routers.entries.map((e) => GetPage(name: e.key, page: e.value)).toList(),
    initialBinding: AppInitBinding(),

    /// 配置404页面: 如果路由不存在则跳到该页面
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(builder: (BuildContext context) => const ErrPage());
    },

    /// 配置页面离开和进入的监听
    navigatorObservers: [MyNavigatorObserver(), routeObserver],
    routingCallback: (Routing? routing) {
      Log.d('cur route: ${routing?.current}  name: ${routing?.route?.settings.name}');
    },

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
  primaryColor: Colors.blue,

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
  splashColor: Colors.pink,

  /// 鼠标悬停颜色 对MaterialButton背景颜色有效
  // hoverColor: Colors.amberAccent,

  /// 获取焦点颜色 无效 ？
  focusColor: Colors.orange,
);

/// ============== TextButtonTheme 配置 ===============
TextButtonThemeData textButtonTheme = const TextButtonThemeData(
  style: ButtonStyle(
      //  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(99, 152, 203, 82)),
      splashFactory: NoSplash.splashFactory // 为什么无效？
      ),
);

/// 5. MaterialApp种配置默认页面的三种方式，1.home  2.initialRoute(需要和routes配合使用)， 3. routes种的/

class AppInitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppInitController());
  }
}

class AppInitController extends GetxController {

  @override
  void onInit() {
    /// 强制竖屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    super.onInit();
  }
  @override
  Future<void> onReady() async {
    super.onReady();
    var appInfo = await EnvironmentConfig.getAppInfo();
    Log.i(EnvironmentConfig.getEnvInfo() + appInfo);

  }
}
