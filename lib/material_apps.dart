import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_flutter_lib_3/flutter_learn/note16_custom_scroll_sample2.dart';
import 'package:my_flutter_lib_3/flutter_learn/note03_button_sample_page.dart';
import 'package:my_flutter_lib_3/pages/err_page.dart';
import 'package:my_flutter_lib_3/pages/page1.dart';
import 'package:my_flutter_lib_3/pages/page2.dart';
import 'package:my_flutter_lib_3/pages/page3.dart';

import 'flutter_learn/note20_2_tween_anim_builder_sample.dart';
import 'flutter_learn/note23_datetime_range_sample.dart';
import 'flutter_learn/note24_shared_pref_sample.dart';
import 'flutter_learn/note26_custom_tab.dart';
import 'flutter_learn/note27_log_test.dart';
import 'flutter_learn/note28_dialog.dart';
import 'flutter_learn/note29_scroll_radio_group.dart';
import 'flutter_learn/note30_indicator_tab_group.dart';
import 'flutter_learn/note31_list_view_state_save.dart';
import 'flutter_learn/note32_screen_adapter.dart';
import 'flutter_learn/note33_widget_binding_observe.dart';
import 'flutter_learn/note34_route_aware.dart';
import 'flutter_learn/note35_exception.dart';
import 'flutter_learn/other/note211_will_pos_scope.dart';
import 'flutter_learn/note06_chexobx_radio_sample.dart';
import 'flutter_learn/note07_form_sample.dart';
import 'flutter_learn/note08_stack_wrap_sample_page.dart';
import 'flutter_learn/note09_imge_sample_page.dart';
import 'flutter_learn/note10_container_sample.dart';
import 'flutter_learn/note11_linear_layout_sample.dart';
import 'flutter_learn/note12_scroll_sample.dart';
import 'flutter_learn/note13_nested_scroll_sample.dart';
import 'flutter_learn/note14_nested_scroll_sample2.dart';
import 'flutter_learn/note15_custom_scroll_sample.dart';
import 'flutter_learn/note17_2_grid_view_sample.dart';
import 'flutter_learn/note17_list_view_sample.dart';
import 'flutter_learn/note18_refresh_view_sample.dart';
import 'flutter_learn/note19_smart_refresh_sample.dart';
import 'flutter_learn/note00_page_indicaotr_sample.dart';
import 'flutter_learn/note02_provider_sample.dart';
import 'flutter_learn/note01_scaffold_sample.dart';
import 'flutter_learn/note05_text_field_sample.dart';
import 'flutter_learn/note04_text_sample.dart';
import 'flutter_learn/note20_1_animate_sample.dart';
import 'flutter_learn/note21_hero_anim.dart';
import 'flutter_learn/note22_backdrop_filter.dart';
import 'navigator/observer.dart';
import 'network/http_sample_ui.dart';

//?????????????????? ?????????????????????????????????main???dart?????????main????????????????????????flutter material???????????????
void main() {
  runApp(getMaterialApp());
}


RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Widget getMaterialApp() {
  /// ?????? GetMaterialApp ??????MaterialApp ???????????????Get.to(_SecondPage()) ????????????
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    /// title ??????Android?????????ios????????????????????????????????? Info.pList ????????????CFBundleDisplayName???CFBundleName
    title: "app??????",

    /// 1. ????????????????????????????????????????????????????????????????????????????????????
    /// 2. ThemeData ??? MaterialDesign Widget????????????????????? Material??????Widget?????????????????????????????????
    /// 3. ???????????????????????????????????????ThemeData, ?????????ThemeData????????????Material????????????
    /// 4. Theme.of??????????????????????????? ThemeData???MaterialDesign??????????????????????????????????????????????????????
    theme: appThemeData,

    /// routes ????????????????????????Map<String, WidgetBuilder>
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
      '/CheckboxSamplePage': (BuildContext context) => const CheckboxSamplePage(),
      '/FormSamplePage': (BuildContext context) => const FormSamplePage(),
      '/StackAndWrapSamplePage': (BuildContext context) => const StackAndWrapSamplePage(),
      '/ImageSamplePage': (BuildContext context) => const ImageSamplePage(),
      '/ContainerSamplePage': (BuildContext context) => const ContainerSamplePage(),
      '/LinearLayoutSamplePage': (BuildContext context) => const LinearLayoutSamplePage(),
      '/SingleChildScrollViewSamplePage': (BuildContext context) => const SingleChildScrollViewSamplePage(),
      '/NestedScrollViewSamplePage': (BuildContext context) => const NestedScrollViewSamplePage(),
      '/NestedScrollViewSamplePage2': (BuildContext context) => const NestedScrollViewSamplePage2(),
      '/CustomScrollViewSamplePage': (BuildContext context) => const CustomScrollViewSamplePage(),
      '/CustomScrollViewSample2Page': (BuildContext context) => const CustomScrollViewSample2Page(),
      '/ListViewSamplePage': (BuildContext context) => const ListViewSamplePage(),
      '/GridViewSamplePage': (BuildContext context) => const GridViewSamplePage(),
      '/RefreshSamplePage': (BuildContext context) => const RefreshSamplePage(),
      '/SmartRefreshSamplePage': (BuildContext context) => const SmartRefreshSamplePage(),
      '/AnimationSamplePage': (BuildContext context) => const AnimationSamplePage(),
      '/TweenAnimationBuilderTestPage': (BuildContext context) => const TweenAnimationBuilderTestPage(),
      '/HeroSample': (BuildContext context) => const HeroSample(),
      '/BackdropFilterPage': (BuildContext context) => const BackdropFilterPage(),
      '/WillPopScopeSamplePage': (BuildContext context) => const WillPopScopeSamplePage(),
      '/DateRangePickerPage': (BuildContext context) => const DateRangePickerPage(),
      '/DioHttpSamplePage': (BuildContext context) => const DioHttpSamplePage(),
      '/SharedPreferencesSamplePage': (BuildContext context) => const SharedPreferencesSamplePage(),
      '/CustomTabSamplePage': (BuildContext context) => const CustomTabSamplePage(),
      '/LogTestSamplePage': (BuildContext context) => const LogTestSamplePage(),
      '/DialogSamplePage': (BuildContext context) => const DialogSamplePage(),
      '/ScrollRadioGroupPage': (BuildContext context) => const ScrollRadioGroupPage(),
      '/IndicatorTabGroupPage': (BuildContext context) => const IndicatorTabGroupPage(),
      '/ListViewStateSaveTestPage': (BuildContext context) => const ListViewStateSaveTestPage(),
      '/ScreenAdapterTestPage': (BuildContext context) => const ScreenAdapterTestPage(),
      '/WidgetsBindingObserverTestPage': (BuildContext context) => const WidgetsBindingObserverTestPage(),
      '/RouteAwareTestPage': (BuildContext context) => const RouteAwareTestPage(),
      '/ExceptionTestPage': (BuildContext context) => const ExceptionTestPage(),

    },

    /// ??????404??????: ???????????????????????????????????????
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(builder: (BuildContext context) => const ErrPage());
    },

    /// ????????????????????????????????????
    navigatorObservers: [MyNavigatorObserver(), routeObserver],

    /// ??? routes ?????? / ????????????????????? ????????????????????????????????????
    ///   initialRoute: '/page1',
    /// home ??? routes????????? / ?????? ????????????????????????
    ///  home: const Page1()
  );
}

/// ============== Theme ?????? ===============
ThemeData appThemeData = ThemeData(
  /// primarySwatch ??????????????????floatActionButton???????????????
  primarySwatch: Colors.blue,

  /// brightness ??????????????????????????????, ???????????????????????????????????????(?????????????????????)
  brightness: Brightness.light,

  /// ??????????????????
  primaryColor: Colors.blue,

  /// ?????? appBarTheme??? ??????????????????????????? primarySwatch
  appBarTheme: appBarTheme,

  /// ?????? app ?????????icon ????????????
  iconTheme: const IconThemeData(color: Colors.amber, size: 28, opacity: 0.86),

  /// ?????? app ?????????icon ????????????: ??????appBarTheme ?????????????????????????????? ??? primaryColor???????????????????????????
  primaryIconTheme: const IconThemeData(color: Colors.orange, size: 28, opacity: 0.86),

  ///  ??????button ????????????
 // highlightColor: Colors.transparent,

 //  splashColor: Colors.red,

  buttonTheme: buttonTheme,

  /// ??????button ??? theme
  textButtonTheme: textButtonTheme,
);

///  ============== AppBarTheme ?????? ===============
AppBarTheme appBarTheme = const AppBarTheme(
  ///  ??????app bar ????????????
  color: Color.fromARGB(255, 50, 197, 40),

  /// ??????????????????
  elevation: 20,

  /// ??????app bar ??????icon ?????? ??????, ????????????
  iconTheme: IconThemeData(color: Color.fromARGB(222, 255, 255, 255), size: 28, opacity: 1),

  ///  ??????app bar ??????????????????
  actionsIconTheme: IconThemeData(color: Colors.white, size: 28, opacity: 1),
);

/// ============== ButtonTheme ?????? ===============
ButtonThemeData buttonTheme = const ButtonThemeData(
  textTheme: ButtonTextTheme.normal,

  /// ???????????????????????????   --?????????
  highlightColor: Colors.purple,

  /// ??????????????????????????????
  disabledColor: Colors.grey,

  buttonColor: Colors.green,

  /// ?????? ???
  splashColor: Colors.pink,

  /// ?????????????????? ???MaterialButton??????????????????
  // hoverColor: Colors.amberAccent,

  /// ?????????????????? ?????? ???
  focusColor: Colors.orange,
);

/// ============== TextButtonTheme ?????? ===============
TextButtonThemeData textButtonTheme = const TextButtonThemeData(
  style: ButtonStyle(
      //  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(99, 152, 203, 82)),
      splashFactory: NoSplash.splashFactory // ??????????????????
      ),
);

/// 5. MaterialApp???????????????????????????????????????1.home  2.initialRoute(?????????routes????????????)??? 3. routes??????/
