import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresh_state.dart';
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
    this.headerLoadEnable = true,
    this.onHeaderLoad,
    this.onFooterLoad,
    required this.controller,
    // false表示头部为刷新功能 true表示头部为加载更多功能, 加载更多可能会自动偏移以自然显示出部分加载的新内容
    this.headerIsLoadMore = false,
  });

  final Widget child;
  final ScrollController sc;
  final double height;
  final double width;
  final OnRefresh? onHeaderLoad;
  final OnLoadMore? onFooterLoad;
  final bool headerIsLoadMore;
  final bool headerLoadEnable;
  final RefresherController controller;

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
        onStartFling(dY);
      }
      lastOffset = sc.offset;
    });
  }

  void onStartFling(double speed) {
    // Log.d("onStartFling speed:$speed");
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
    return Container(
      height: headerHeight,
      color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: Colors.blue,
            height: headerIndicatorHeight,
            width: widget.width,
            alignment: Alignment.center,
            child: headerWidgetBuilder.getHeaderWidget(curRefreshState),
          ),
        ],
      ),
    );
  }

  Future<void> onPointerUp(PointerUpEvent event) async {
    isPressed = false;
    if(headerIsShowing()){
      onStartFling(realTouchMoveDy);
    }
    if (isLoadingOrFinishedState()) {
      return;
    }
    if (headerIsShowing()) {
      // 释放加载 => 正在加载 或下拉加载状态不变，回到隐藏头
      var tarHeaderState = getTarHeaderState();
      if (tarHeaderState != curRefreshState) {
        updateHeaderState(2);
        if (curRefreshState == RefreshState.header_loading && widget.onHeaderLoad != null) {
          widget.onHeaderLoad!(this);
        }
      }
      animUpdateHeader();
    }
  }

  bool isScrollToTop() {
    if (widget.headerIsLoadMore) {
      return sc.position.extentAfter == 0;
    } else {
      return sc.position.extentBefore == 0;
    }
  }

  bool isScrollToBot() {
    if (widget.headerIsLoadMore) {
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

  RefreshState curRefreshState = RefreshState.header_pull_down_load;

  void onPointerMove(PointerMoveEvent e) {
    double newValue = notifier.value + e.delta.dy;
    if (sc.position.physics is RefresherClampingScrollPhysics) {
      RefresherClampingScrollPhysics physics = sc.position.physics as RefresherClampingScrollPhysics;
      physics.scrollEnable = headerIsHidden();
      if (isLoadingOrFinishedState()) {
        physics.scrollEnable = false;
      }
    } else {
      throw Exception("滚动Widget的physics必须是 RefresherClampingScrollPhysics");
    }
    if (isLoadingOrFinishedState()) {
      return;
    }
    if (isScrollToTop()) {
      if (widget.headerLoadEnable) {
        handleHeaderScroll(e, newValue, true);
      }
    } else if (isScrollToBot()) {}
  }

  double realTouchMoveDy = 0;

  void handleHeaderScroll(PointerMoveEvent e, double newValue, bool isTouchMove) {
    double scrolledHeaderY = getScrolledHeaderY();
    double temValue = notifier.value;
    if (e.delta.dy > 0) {
      // header 向下滑动
      double scrolledRate = scrolledHeaderY / headerHeight;
      newValue = notifier.value + (e.delta.dy * (1 - scrolledRate));
      if (newValue > 0) newValue = 0;
      notifier.value = newValue;
    } else if (e.delta.dy < 0) {
      // header 向上滑动
      if (newValue < -headerHeight) newValue = -headerHeight;
      notifier.value = newValue;
    }
    realTouchMoveDy = notifier.value - temValue;
    //头部触摸移动只有两种状态切换（下拉加载，释放加载）
    RefreshState tarState = getTarHeaderState();
    if (tarState != curRefreshState) {
      updateHeaderState(1);
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
    }
    if (curRefreshState == RefreshState.header_pull_down_load) {
      refreshFinishOffset = 0;
    }
   // Log.d("curRefreshState: ${curRefreshState.name} : ${curRefreshState.index}  switchType:$switchType ");
  }

  Future<void> onLoadFinished() async {
    notifier.value += 0.1; // 更新UI
    // 在次状态停顿200毫秒后隐藏头部，恢复下拉加载状态
    await Future.delayed(const Duration(milliseconds: 260));
    if (widget.headerIsLoadMore && widget.controller.isHeaderOffsetOnLoadFinished) {
      refreshFinishOffset = -headerHeight;
      notifier.value -= 0.1; // 更新UI
      sc.jumpTo(sc.offset + headerTriggerRefreshDistance);
    }
    await Future.delayed(const Duration(milliseconds: 40));
    animUpdateHeader();
  }

  void notifyRefreshFinish() {
    //  正在加载->加载结束
    updateHeaderState(3);
    onLoadFinished();
  }
}

class RefresherController {
  /// 如果加载跟多没有加载到更多的内容，或者加载的内容不足做偏移， 则可不做偏移
  bool isHeaderOffsetOnLoadFinished = true;
}
