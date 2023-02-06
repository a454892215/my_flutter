import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresh_state.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresher.dart';
import 'dart:math' as math;

import '../../util/math_util.dart';
import '../comm_anim2.dart';

class HeaderHandler {
  final ValueNotifier<double> notifier;
  final RefreshWidgetState state;
  late Refresher widget;
  late CommonTweenAnim<double> animFling;

  HeaderHandler(this.notifier, this.state) {
    widget = state.widget;
    animFling = state.animFling;
  }

  double lastRealTouchMoveDy = 0;
  void handleHeaderTouchScroll(PointerMoveEvent e) {
    var param = state.param;
    double tarScrollY = notifier.value + e.delta.dy;
    double scrolledHeaderY = getScrolledHeaderY();
    double scrolledRatio = scrolledHeaderY / state.param.headerHeight;
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
    if (state.widget.headerFnc == RefresherFunc.refresh || state.widget.headerFnc == RefresherFunc.load_more) {
      //头部触摸移动只有两种状态切换（下拉加载，释放加载）
      RefreshState tarState = state.stateManager.getTarHeaderState();
      if (tarState != state.stateManager.curRefreshState) {
        state.stateManager.updateHeaderState(1);
      }
    }
  }

  void onStartHeaderFling(double speed) {
    if (widget.headerFnc == RefresherFunc.no_func) {
      return;
    }
    if (MathU.abs(speed) > 100) {
      speed = MathU.mode(speed) * 100;
    }
    int during = (MathU.abs(speed) * 3).toInt();
    during = math.max(50, during);
    during = math.min(250, during);
    animFling.controller.stop();
    animFling.init(during, state, 0, 1);
    bool isIntoLoadingState = false;
    var stateManager = state.stateManager;
    animFling.addListener(() {
      var animValue = animFling.animation?.value ?? 0;
      double scrolledRatio = getScrolledHeaderY() / state.param.headerHeight;
      animValue = animValue * math.pow((1 - scrolledRatio), 2);
      notifier.value += animValue;
      //  Log.d("fling animValue: $animValue  during:$during  speed:$speed");
      // 只有加载更多和刷新需要更新状态
      if (widget.headerFnc == RefresherFunc.refresh || widget.headerFnc == RefresherFunc.load_more) {
        RefreshState tarState = state.stateManager.getTarHeaderState();
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

  Future<void> onHeaderLoadFinished() async {
    notifier.value += 0.1; // 更新UI
    // 在次状态停顿200毫秒后隐藏头部，恢复下拉加载状态
    await Future.delayed(const Duration(milliseconds: 260));
    if (widget.headerFnc == RefresherFunc.load_more && widget.controller.isNeedHeaderOffsetOnLoadFinished) {
      state.param.refreshFinishOffset = -state.param.headerHeight;
      notifier.value -= 0.1; // 更新UI
      state.sc.jumpTo(state.sc.offset + state.param.headerTriggerRefreshDistance);
    }
    await Future.delayed(const Duration(milliseconds: 40));
    animUpdateHeader();
  }


  void animUpdateHeader() {
    if (state.stateManager.curRefreshState == RefreshState.header_loading) {
      state.anim.update(-(state.param.headerHeight - state.param.headerTriggerRefreshDistance), begin: notifier.value);
    } else if (state.stateManager.curRefreshState == RefreshState.header_load_finished) {
      state.anim.update(-state.param.headerHeight, begin: notifier.value);
    } else {
      state.anim.update(-state.param.headerHeight, begin: notifier.value);
    }
    state.anim.controller.forward(from: 0);
  }


  bool headerIsHidden() {
    return notifier.value <= -state.param.headerHeight;
  }

  bool headerIsShowing() {
    return notifier.value > -state.param.headerHeight;
  }

  double getScrolledHeaderY() {
    return state.param.headerHeight + notifier.value;
  }

  bool isLoadingOrFinishedState() {
    return state.stateManager.curRefreshState == RefreshState.header_loading || state.stateManager.curRefreshState == RefreshState.header_load_finished;
  }
}
