import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresh_state.dart';
import 'dart:math' as math;
import '../../util/Log.dart';
import '../comm_anim2.dart';
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
  static double headerHeight = 180;
  static double headerIndicatorHeight = 60;

  late final ValueNotifier<double> notifier = ValueNotifier<double>(-headerHeight);

  late CommonTweenAnim<double> anim = CommonTweenAnim<double>()
    ..init(200, this, 0, 1)
    ..addListener(onAnimUpdate);

  int state = 0;
  double headerTriggerRefreshDistance = headerIndicatorHeight;

  /// 加载结束后，瞬时偏移量，使部分新内容自然显示出来
  double refreshFinishOffset = 0;

  void onAnimUpdate() {
    notifier.value = anim.animation?.value ?? -headerHeight;
    if (anim.controller.isCompleted && state != 1) {
      state = 1;
      if (curRefreshState == RefreshState.header_load_finished) {
        // 加载完成->头部收回（恢复状态）
        updateHeaderState(4);
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
              top: headerHeight,
              child: Transform.translate(
                offset: Offset(0, refreshFinishOffset != 0 ? refreshFinishOffset : notifier.value),
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
        ],
      ),
    );
  }

  HeaderWidgetBuilder headerWidgetBuilder = HeaderWidgetBuilder();

  Widget _buildHeader() {
    return SizedBox(
      height: headerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: headerIndicatorHeight,
            width: widget.width,
            alignment: Alignment.center,
            child: headerWidgetBuilder.getHeaderWidget(curRefreshState, widget.headerFnc),
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
    return notifier.value <= -headerHeight;
  }

  bool headerIsShowing() {
    return notifier.value > -headerHeight;
  }

  double getScrolledHeaderY() {
    return headerHeight + notifier.value;
  }

  bool isLoadingOrFinishedState() {
    return curRefreshState == RefreshState.header_loading || curRefreshState == RefreshState.header_load_finished;
  }

  void animUpdateHeader() {
    if (curRefreshState == RefreshState.header_loading) {
      anim.update(-(headerHeight - headerTriggerRefreshDistance), begin: notifier.value);
    } else if (curRefreshState == RefreshState.header_load_finished) {
      anim.update(-headerHeight, begin: notifier.value);
    } else {
      anim.update(-headerHeight, begin: notifier.value);
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
      double scrolledRatio = getScrolledHeaderY() / headerHeight;
      animValue = animValue * math.pow((1 - scrolledRatio), 2);
      notifier.value += animValue;
      //  Log.d("fling animValue: $animValue  during:$during  speed:$speed");
      // 只有加载更多和刷新需要更新状态
      if (widget.headerFnc == RefresherFunc.refresh || widget.headerFnc == RefresherFunc.load_more) {
        RefreshState tarState = getTarHeaderState();
        if (!isIntoLoadingState && tarState != curRefreshState) {
          updateHeaderState(5);
          if (curRefreshState == RefreshState.header_release_load) {
            updateHeaderState(5); // 直接进入正在加载状态
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

  RefreshState curRefreshState = RefreshState.header_pull_down_load;

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
    double scrolledRatio = scrolledHeaderY / headerHeight;
    tarScrollY = notifier.value + (e.delta.dy * math.pow((1 - scrolledRatio), 2));
    double temValue = notifier.value;
    // header 向下滑动
    if (e.delta.dy > 0) {
      if (tarScrollY > 0) tarScrollY = 0;
      notifier.value = tarScrollY;
    } else if (e.delta.dy < 0) {
      // header 向上滑动
      if (tarScrollY < -headerHeight) tarScrollY = -headerHeight;
      notifier.value = tarScrollY;
    }
    lastRealTouchMoveDy = notifier.value - temValue;
    // 反弹效果功能不需要更新状态
    if (widget.headerFnc == RefresherFunc.refresh || widget.headerFnc == RefresherFunc.load_more) {
      //头部触摸移动只有两种状态切换（下拉加载，释放加载）
      RefreshState tarState = getTarHeaderState();
      if (tarState != curRefreshState) {
        updateHeaderState(1);
      }
    }
  }

  RefreshState getTarHeaderState() {
    RefreshState tarState = curRefreshState;
    if (curRefreshState == RefreshState.header_release_load && !isPressed) {
      tarState = RefreshState.header_loading;
    } else if (!isLoadingOrFinishedState()) {
      if (getScrolledHeaderY() >= headerTriggerRefreshDistance) {
        tarState = RefreshState.header_release_load;
      } else {
        tarState = RefreshState.header_pull_down_load;
      }
    }
    return tarState;
  }

  Future<void> updateHeaderState(int switchType) async {
    if (switchType == 1) {
      if (curRefreshState == RefreshState.header_pull_down_load) {
        curRefreshState = RefreshState.header_release_load;
      } else {
        curRefreshState = RefreshState.header_pull_down_load;
      }
    } else if (switchType == 2) {
      // 释放加载 => 正在加载 或下拉加载状态不变，动画隐藏头
      if (curRefreshState == RefreshState.header_release_load) {
        curRefreshState = RefreshState.header_loading;
      }
    } else if (switchType == 3) {
      // 正在加载->加载结束
      if (curRefreshState == RefreshState.header_loading) {
        curRefreshState = RefreshState.header_load_finished;
      }
    } else if (switchType == 4) {
      // 加载结束 -> 下拉加载
      if (curRefreshState == RefreshState.header_load_finished) {
        curRefreshState = RefreshState.header_pull_down_load;
      }
    } else if (switchType == 5) {
      // 下拉加载 -> 释放加载
      if (curRefreshState == RefreshState.header_pull_down_load) {
        curRefreshState = RefreshState.header_release_load;
      } else if (curRefreshState == RefreshState.header_release_load) {
        curRefreshState = RefreshState.header_loading;
      }
    }
    if (curRefreshState == RefreshState.header_pull_down_load) {
      refreshFinishOffset = 0;
    } else if (curRefreshState == RefreshState.header_loading) {
      if (widget.onHeaderLoad != null) {
        widget.onHeaderLoad!(this);
      }
    }
    Log.d("curRefreshState: ${curRefreshState.name} : ${curRefreshState.index}  switchType:$switchType ");
  }

  Future<void> onLoadFinished() async {
    notifier.value += 0.1; // 更新UI
    // 在次状态停顿200毫秒后隐藏头部，恢复下拉加载状态
    await Future.delayed(const Duration(milliseconds: 260));
    if (widget.headerFnc == RefresherFunc.load_more && widget.controller.isNeedHeaderOffsetOnLoadFinished) {
      refreshFinishOffset = -headerHeight;
      notifier.value -= 0.1; // 更新UI
      sc.jumpTo(sc.offset + headerTriggerRefreshDistance);
    }
    await Future.delayed(const Duration(milliseconds: 40));
    animUpdateHeader();
  }

  void notifyHeaderLoadFinish() {
    //  正在加载->加载结束
    updateHeaderState(3);
    onLoadFinished();
  }
}

class RefresherController {
  /// 如果加载跟多没有加载到更多的内容，或者加载的内容不足做偏移， 则可不做偏移
  bool isNeedHeaderOffsetOnLoadFinished = true;
}
