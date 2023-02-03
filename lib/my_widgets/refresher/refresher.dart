import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresh_state.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresher_param.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/state_manager.dart';
import 'dart:math' as math;
import '../comm_anim2.dart';
import 'footer_indicator_widget.dart';
import 'my_physics.dart';
import 'header_indicator_widget.dart';

void main() {}

typedef OnRefresh = void Function(RefreshWidgetState state);
typedef OnLoadMore = void Function(RefreshWidgetState state);

class Refresher extends StatefulWidget {
  const Refresher({
    super.key,
    required this.child,
    required this.sc,
    required this.height,
    required this.width,
    this.headerFnc = RefresherFunc.refresh,
    this.isReverseScroll = true,
    this.onHeaderLoad,
    this.onFooterLoad,
    required this.controller,
  });

  final Widget child;
  final ScrollController sc;
  final double height;
  final double width;
  final OnRefresh? onHeaderLoad;
  final OnLoadMore? onFooterLoad;
  final RefresherFunc headerFnc;
  final RefresherController controller;
  final bool isReverseScroll;

  @override
  State<StatefulWidget> createState() {
    return RefreshWidgetState();
  }
}

class RefreshWidgetState extends State<Refresher> with TickerProviderStateMixin {
  late ScrollController sc = widget.sc;
  RefresherParam param = RefresherParam();

  late final ValueNotifier<double> notifier = ValueNotifier<double>(-param.headerHeight);

  late CommonTweenAnim<double> anim = CommonTweenAnim<double>()
    ..init(200, this, 0, 1)
    ..addListener(onAnimUpdate);

  int state = 0;

  late StateManager stateManager = StateManager(widget, param, this);

  void onAnimUpdate() {
    notifier.value = anim.animation?.value ?? -param.headerHeight;
    if (anim.controller.isCompleted && state != 1) {
      state = 1;
      if (stateManager.curRefreshState == RefreshState.header_load_finished) {
        // 加载完成->头部收回（恢复状态）
        stateManager.updateHeaderState(4);
      }
    } else if (anim.controller.isDismissed && state != -1) {
      state = -1;
    } else {
      state = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    double lastOffset = 0;
    sc.addListener(() {
      double dY = sc.offset - lastOffset;
      if (isScrollToTop() && !isPressed) {
        // 头尾不可见
        onStartFling(dY);
      }
      lastOffset = sc.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (a, b, c) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: OverflowBox(
            alignment: Alignment.topLeft,
            maxHeight: widget.height * 3,
            child: _buildContent(),
          ),
        );
      },
    );
  }

  bool isPressed = false;

  Widget _buildContent() {
    return ClipRRect(
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Positioned(
              left: 0,
              top: param.headerHeight,
              child: Transform.translate(
                offset: Offset(0, param.refreshFinishOffset != 0 ? param.refreshFinishOffset : notifier.value),
                child: Listener(
                  onPointerMove: onPointerMove,
                  onPointerUp: onPointerUp,
                  onPointerDown: (e) {
                    if (animFling.controller.isAnimating) {
                      animFling.controller.stop();
                    }
                    isPressed = true;
                  },
                  child: widget.child,
                ),
              )),
          Transform.translate(
            offset: Offset(0, notifier.value),
            child: _buildHeader(),
          ),
          // Transform.translate(
          //   offset: Offset(0, 0),
          //   child: _buildFooter(),
          // ),
        ],
      ),
    );
  }

  HeaderWidgetBuilder headerWidgetBuilder = HeaderWidgetBuilder();
  FooterWidgetBuilder footerWidgetBuilder = FooterWidgetBuilder();

  Widget _buildHeader() {
    return SizedBox(
      height: param.headerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: param.headerIndicatorHeight,
            width: widget.width,
            alignment: Alignment.center,
            child: headerWidgetBuilder.getHeaderWidget(stateManager.curRefreshState, widget.headerFnc),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return SizedBox(
      height: param.footerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: param.footerIndicatorHeight,
            width: widget.width,
            color: Colors.blue,
            alignment: Alignment.center,
            child: footerWidgetBuilder.getFooterWidget(stateManager.curRefreshState, widget.headerFnc),
          ),
        ],
      ),
    );
  }

  Future<void> onPointerUp(PointerUpEvent event) async {
    isPressed = false;
    if (headerIsShowing()) {
      onStartFling(lastRealTouchMoveDy * 8);
    }
  }

  bool isScrollToTop() {
    if (widget.isReverseScroll) {
      return sc.position.extentAfter == 0;
    } else {
      return sc.position.extentBefore == 0;
    }
  }

  bool isScrollToBot() {
    if (widget.isReverseScroll) {
      return sc.position.extentBefore == 0;
    } else {
      return sc.position.extentAfter == 0;
    }
  }

  bool headerIsHidden() {
    return notifier.value <= -param.headerHeight;
  }

  bool headerIsShowing() {
    return notifier.value > -param.headerHeight;
  }

  double getScrolledHeaderY() {
    return param.headerHeight + notifier.value;
  }

  bool isLoadingOrFinishedState() {
    return stateManager.curRefreshState == RefreshState.header_loading || stateManager.curRefreshState == RefreshState.header_load_finished;
  }

  void animUpdateHeader() {
    if (stateManager.curRefreshState == RefreshState.header_loading) {
      anim.update(-(param.headerHeight - param.headerTriggerRefreshDistance), begin: notifier.value);
    } else if (stateManager.curRefreshState == RefreshState.header_load_finished) {
      anim.update(-param.headerHeight, begin: notifier.value);
    } else {
      anim.update(-param.headerHeight, begin: notifier.value);
    }
    anim.controller.forward(from: 0);
  }

  late CommonTweenAnim<double> animFling = CommonTweenAnim<double>()..init(200, this, 0, 1);

  void onStartFling(double speed) {
    if (widget.headerFnc == RefresherFunc.no_func) {
      return;
    }
    int during = (speed * 3).toInt();
    during = math.max(50, during);
    during = math.min(250, during);
    animFling.controller.stop();
    animFling.init(during, this, 0, 1);
    bool isIntoLoadingState = false;
    animFling.addListener(() {
      var animValue = animFling.animation?.value ?? 0;
      double scrolledRatio = getScrolledHeaderY() / param.headerHeight;
      animValue = animValue * math.pow((1 - scrolledRatio), 2);
      notifier.value += animValue;
      //  Log.d("fling animValue: $animValue  during:$during  speed:$speed");
      // 只有加载更多和刷新需要更新状态
      if (widget.headerFnc == RefresherFunc.refresh || widget.headerFnc == RefresherFunc.load_more) {
        RefreshState tarState = stateManager.getTarHeaderState();
        if (!isIntoLoadingState && tarState != stateManager.curRefreshState) {
          stateManager.updateHeaderState(5);
          if (stateManager.curRefreshState == RefreshState.header_release_load) {
            stateManager.updateHeaderState(5); // 直接进入正在加载状态
            isIntoLoadingState = true;
            return;
          }
        }
      }
      // 此处可能是处于正在加载/加载完成或者下拉刷新状态
      if (animValue == 0 && headerIsShowing()) {
        animUpdateHeader();
      }
    });
    animFling.update(0, begin: speed);
    animFling.controller.forward(from: 0);
    // Log.d("onStartFling speed:$speed");
  }

  void onPointerMove(PointerMoveEvent e) {
    if (widget.headerFnc == RefresherFunc.no_func) {
      return;
    }
    // 以下处理三种功能，刷新，加载更多， 反弹效果
    if (sc.position.physics is RefresherClampingScrollPhysics) {
      RefresherClampingScrollPhysics physics = sc.position.physics as RefresherClampingScrollPhysics;
      physics.scrollEnable = headerIsHidden();
      if (isLoadingOrFinishedState()) {
        physics.scrollEnable = false;
      }
    } else {
      throw Exception("滚动 Widget 的 physics 必须是 RefresherClampingScrollPhysics ");
    }
    if (isLoadingOrFinishedState()) {
      return;
    }
    if (isScrollToTop()) {
      handleHeaderTouchScroll(e);
    } else if (isScrollToBot()) {}
  }

  double lastRealTouchMoveDy = 0;

  void handleHeaderTouchScroll(PointerMoveEvent e) {
    double tarScrollY = notifier.value + e.delta.dy;
    double scrolledHeaderY = getScrolledHeaderY();
    double scrolledRatio = scrolledHeaderY / param.headerHeight;
    tarScrollY = notifier.value + (e.delta.dy * math.pow((1 - scrolledRatio), 2));
    double temValue = notifier.value;
    // header 向下滑动
    if (e.delta.dy > 0) {
      if (tarScrollY > 0) tarScrollY = 0;
      notifier.value = tarScrollY;
    } else if (e.delta.dy < 0) {
      // header 向上滑动
      if (tarScrollY < -param.headerHeight) tarScrollY = -param.headerHeight;
      notifier.value = tarScrollY;
    }
    lastRealTouchMoveDy = notifier.value - temValue;
    // 反弹效果功能不需要更新状态
    if (widget.headerFnc == RefresherFunc.refresh || widget.headerFnc == RefresherFunc.load_more) {
      //头部触摸移动只有两种状态切换（下拉加载，释放加载）
      RefreshState tarState = stateManager.getTarHeaderState();
      if (tarState != stateManager.curRefreshState) {
        stateManager.updateHeaderState(1);
      }
    }
  }

  Future<void> onHeaderLoadFinished() async {
    notifier.value += 0.1; // 更新UI
    // 在次状态停顿200毫秒后隐藏头部，恢复下拉加载状态
    await Future.delayed(const Duration(milliseconds: 260));
    if (widget.headerFnc == RefresherFunc.load_more && widget.controller.isNeedHeaderOffsetOnLoadFinished) {
      param.refreshFinishOffset = -param.headerHeight;
      notifier.value -= 0.1; // 更新UI
      sc.jumpTo(sc.offset + param.headerTriggerRefreshDistance);
    }
    await Future.delayed(const Duration(milliseconds: 40));
    animUpdateHeader();
  }

  void notifyHeaderLoadFinish() {
    //  正在加载->加载结束
    stateManager.updateHeaderState(3);
    onHeaderLoadFinished();
  }
}

class RefresherController {
  /// 如果加载跟多没有加载到更多的内容，或者加载的内容不足做偏移， 则可不做偏移
  bool isNeedHeaderOffsetOnLoadFinished = true;
}
