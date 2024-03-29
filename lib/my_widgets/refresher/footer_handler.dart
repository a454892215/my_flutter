import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresh_state.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresher.dart';
import 'dart:math' as math;

import '../../util/Log.dart';
import '../../util/math_util.dart';
import '../comm_anim2.dart';

class FooterHandler {
  final ValueNotifier<double> notifier;
  final RefreshWidgetState state;
  late Refresher widget;

  late CommonTweenAnim<double> anim = CommonTweenAnim<double>()
    ..init(200, state, 0, 1)
    ..addListener(onAnimUpdate);

  late CommonTweenAnim<double> animFling = CommonTweenAnim<double>()..init(200, state, 0, 1);

  FooterHandler(this.notifier, this.state) {
    widget = state.widget;
  }

  int animState = 0;

  void onAnimUpdate() {
    notifier.value = anim.animation?.value ?? -state.param.headerHeight;
    if (anim.controller.isCompleted && animState != 1) {
      animState = 1;
      if (state.stateManager.curHeaderRefreshState == RefreshState.header_load_finished) {
        // 加载完成->头部收回（恢复状态）
        state.stateManager.updateHeaderState(4);
      }
    } else if (anim.controller.isDismissed && animState != -1) {
      animState = -1;
    } else {
      animState = 0;
    }
  }

  double lastRealTouchMoveDy = 0;

  void handleFooterTouchScroll(PointerMoveEvent e) {
    var param = state.param;
    double tarScrollY = notifier.value + e.delta.dy;
    if (e.delta.dy < 0 && isShowing()) {
      double scrolledRatio = getScrolledFooterDistance() / state.param.footerHeight;
      tarScrollY = notifier.value + (e.delta.dy * math.pow((1 - scrolledRatio), 2));
    }
    double temValue = notifier.value;
    if (tarScrollY > -param.headerHeight) {
      tarScrollY = -param.headerHeight; // 避免把header滑出
    }
    notifier.value = tarScrollY;
    lastRealTouchMoveDy = notifier.value - temValue;
    state.stateManager.updateFooterState(1);
  }

  void onStartFling(double speed) {
    if (widget.headerFnc == RefresherFunc.no_func) {
      return;
    }
    speed = speed < 0 ? 0 : speed;
    if (speed > 100) speed = 100;
    int during = (MathU.abs(speed) * 3).toInt();
    during = math.max(20, during);
    during = math.min(250, during);
    startFlingScroll(during, speed, 0, () {
      // 速度为0的时候更新下状态
      state.stateManager.updateFooterState(2);
      if (state.stateManager.curFooterRefreshState == RefreshState.footer_pull_up_load) {
        animResetPos(200, null);
      } else if (state.stateManager.curFooterRefreshState == RefreshState.footer_loading) {
        animToLoadingPos(200, null);
      }
    });
  }

  void startFlingScroll(int during, double beginSpeed, double endSpeed, VoidCallback? onAnimEnd) {
    animFling.controller.stop();
    animFling.init(during, state, 0, 1);
    animFling.addListener(() {
      var animValue = animFling.animation?.value ?? 0;
      double scrolledRatio = getScrolledFooterDistance() / state.param.footerHeight;
      animValue = animValue * math.pow((1 - scrolledRatio), 2);
      notifier.value -= animValue;
      if (animFling.controller.isCompleted && onAnimEnd != null) {
        onAnimEnd();
      }
    });
    animFling.update(endSpeed, begin: beginSpeed);
    animFling.controller.forward(from: 0);
  }

  void animResetPos(int during, VoidCallback? onAnimEnd) {
    animFling.controller.stop();
    animFling.init(during, state, notifier.value, notifier.value + getScrolledFooterDistance());
    animFling.addListener(() {
      var animValue = animFling.animation?.value;
      if (animValue != null) {
        notifier.value = animValue;
      }
      if (animFling.controller.isCompleted && onAnimEnd != null) {
        onAnimEnd();
      }
    });
    animFling.controller.forward(from: 0);
  }

  void animToLoadingPos(int during, VoidCallback? onAnimEnd) {
    animFling.controller.stop();
    animFling.init(during, state, notifier.value, -state.param.headerHeight - state.param.footerIndicatorHeight);
    animFling.addListener(() {
      var animValue = animFling.animation?.value;
      if (animValue != null) {
        notifier.value = animValue;
      }
      if (animFling.controller.isCompleted && onAnimEnd != null) {
        onAnimEnd();
      }
    });
    animFling.controller.forward(from: 0);
  }

  Future<void> onFooterLoadFinished() async {
    notifier.value += 0.1; // 更新UI
    // 在此状态停顿200毫秒后隐藏头部，恢复下拉加载状态
    await Future.delayed(const Duration(milliseconds: 260));
    if (widget.footerFnc == RefresherFunc.load_more && widget.controller.isNeedFooterOffsetOnLoadFinished) {
      state.param.loadFinishOffset = -state.param.footerHeight;
      notifier.value -= 0.1; // 更新UI
      state.sc.jumpTo(state.sc.offset + state.param.footerTriggerRefreshDistance);
    }
    await Future.delayed(const Duration(milliseconds: 40));
    animResetPos(20, () => state.stateManager.updateFooterState(4));
  }

  bool isHidden() {
    return getScrolledFooterY() >= 0;
  }

  bool isShowing() {
    return getScrolledFooterY() < 0;
  }

  // 该值小于0的时候 footer 可见
  double getScrolledFooterY() {
    return state.param.headerHeight + notifier.value;
  }

  double getScrolledFooterDistance() {
    var scrolledFooterY = getScrolledFooterY();
    return scrolledFooterY >= 0 ? 0 : -scrolledFooterY;
  }

  bool isLoadingOrFinishedState() {
    return state.stateManager.curFooterRefreshState == RefreshState.footer_loading ||
        state.stateManager.curFooterRefreshState == RefreshState.footer_load_finished;
  }
}
