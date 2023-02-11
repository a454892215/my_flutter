import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_flutter_lib_3/flutter_learn/note16_custom_scroll_sample2.dart';
import 'package:my_flutter_lib_3/flutter_learn/note03_button_sample_page.dart';
import 'package:my_flutter_lib_3/pages/flutter_lib_api_samples.dart';
import 'package:my_flutter_lib_3/pages/flutter_system_api_samples.dart';
import 'package:my_flutter_lib_3/pages/home_page.dart';
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
import 'flutter_learn/note36_cupertinoPicker.dart';
import 'flutter_learn/note37_async_test.dart';
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
import 'network/http_sample_ui.dart';

Map<String, GetPageBuilder> routers = {
  '/': () => const HomePage(),
  '/HomePage': () => const HomePage(),
  '/SystemApiSampleListPage': () => const SystemApiSampleListPage(),
  '/LibApiSamplesPage': () => const LibApiSamplesPage(),
  '/page2': () => const Page2(),
  '/page3': () => const Page3(),
  '/ButtonSamplePage': () => const ButtonSamplePage(),
  '/TabIndicatorSamplePage': () => const TabIndicatorSamplePage(),
  '/ScaffoldSamplePage': () => const ScaffoldSamplePage(),
  '/ProviderSamplePage': () => const ProviderSamplePage(),
  '/TextSamplePage': () => const TextSamplePage(),
  '/TextFieldSamplePage': () => const TextFieldSamplePage(),
  '/CheckboxSamplePage': () => const CheckboxSamplePage(),
  '/FormSamplePage': () => const FormSamplePage(),
  '/StackAndWrapSamplePage': () => const StackAndWrapSamplePage(),
  '/ImageSamplePage': () => const ImageSamplePage(),
  '/ContainerSamplePage': () => const ContainerSamplePage(),
  '/LinearLayoutSamplePage': () => const LinearLayoutSamplePage(),
  '/SingleChildScrollViewSamplePage': () => const SingleChildScrollViewSamplePage(),
  '/NestedScrollViewSamplePage': () => const NestedScrollViewSamplePage(),
  '/NestedScrollViewSamplePage2': () => const NestedScrollViewSamplePage2(),
  '/CustomScrollViewSamplePage': () => const CustomScrollViewSamplePage(),
  '/CustomScrollViewSample2Page': () => const CustomScrollViewSample2Page(),
  '/ListViewSamplePage': () => const ListViewSamplePage(),
  '/GridViewSamplePage': () => const GridViewSamplePage(),
  '/RefreshSamplePage': () => const RefreshSamplePage(),
  '/SmartRefreshSamplePage': () => const SmartRefreshSamplePage(),
  '/AnimationSamplePage': () => const AnimationSamplePage(),
  '/TweenAnimationBuilderTestPage': () => const TweenAnimationBuilderTestPage(),
  '/HeroSample': () => const HeroSample(),
  '/BackdropFilterPage': () => const BackdropFilterPage(),
  '/WillPopScopeSamplePage': () => const WillPopScopeSamplePage(),
  '/DateRangePickerPage': () => const DateRangePickerPage(),
  '/DioHttpSamplePage': () => const DioHttpSamplePage(),
  '/SharedPreferencesSamplePage': () => const SharedPreferencesSamplePage(),
  '/CustomTabSamplePage': () => const CustomTabSamplePage(),
  '/LogTestSamplePage': () => const LogTestSamplePage(),
  '/DialogSamplePage': () => const DialogSamplePage(),
  '/ScrollRadioGroupPage': () => const ScrollRadioGroupPage(),
  '/IndicatorTabGroupPage': () => const IndicatorTabGroupPage(),
  '/ListViewStateSaveTestPage': () => const ListViewStateSaveTestPage(),
  '/ScreenAdapterTestPage': () => const ScreenAdapterTestPage(),
  '/WidgetsBindingObserverTestPage': () => const WidgetsBindingObserverTestPage(),
  '/RouteAwareTestPage': () => const RouteAwareTestPage(),
  '/CupertinoPickerTestPage': () => const CupertinoPickerTestPage(),
  '/AsyncTestPage': () => const AsyncTestPage(),
  '/ExceptionTestPage': () => const ExceptionTestPage(),
};