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
      if (state.stateManager.curRefreshState == RefreshState.header_load_finished) {
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
    double tarScrollY = notifier.value + e.delta.dy;
    if (e.delta.dy < 0 && isShowing()) {
      double scrolledRatio = getScrolledFooterDistance() / state.param.footerHeight;
      tarScrollY = notifier.value + (e.delta.dy * math.pow((1 - scrolledRatio), 2));
    }
    double temValue = notifier.value;
    // header 向下滑动
    if (e.delta.dy > 0) {
      // if (tarScrollY > 0) tarScrollY = 0;
      notifier.value = tarScrollY;
      Log.d("向下滑动  tarScrollY:$tarScrollY ");
    } else if (e.delta.dy < 0) {
      // header 向上滑动
      // if (tarScrollY < -param.headerHeight) tarScrollY = -param.headerHeight;
      notifier.value = tarScrollY;
      //  Log.d("向上滑动  tarScrollY:$tarScrollY ");
    }
    lastRealTouchMoveDy = notifier.value - temValue;
    // 反弹效果功能不需要更新状态
    // if (state.widget.headerFnc == RefresherFunc.refresh || state.widget.headerFnc == RefresherFunc.load_more) {
    //   //头部触摸移动只有两种状态切换（下拉加载，释放加载）
    //   RefreshState tarState = state.stateManager.getTarHeaderState();
    //   if (tarState != state.stateManager.curRefreshState) {
    //     state.stateManager.updateHeaderState(1);
    //   }
    // }
  }

  void onStartFling(double speed) {
    if (widget.headerFnc == RefresherFunc.no_func) {
      return;
    }
    if (MathU.abs(speed) > 100) {
      speed = MathU.mode(speed) * 100;
    }
    Log.d("onStartFling  speed:$speed ");
    int during = (MathU.abs(speed) * 3).toInt();
    during = math.max(50, during);
    during = math.min(250, during);
    startFlingScroll(during, speed, 0, () {
      startResetPoaAnim(200, null);
    });
    // Log.d("onStartFling speed:$speed");
  }

  void startFlingScroll(int during, double beginSpeed, double endSpeed, VoidCallback? onAnimEnd) {
    animFling.controller.stop();
    animFling.init(during, state, 0, 1);
    animFling.addListener(() {
      var animValue = animFling.animation?.value ?? 0;
      double scrolledRatio = getScrolledFooterDistance() / state.param.footerHeight;
      animValue = animValue * math.pow((1 - scrolledRatio), 2);
      notifier.value += animValue;
      if (animFling.controller.isCompleted && onAnimEnd != null) {
        onAnimEnd();
      }
    });
    animFling.update(endSpeed, begin: beginSpeed);
    animFling.controller.forward(from: 0);
  }

  void startResetPoaAnim(int during, VoidCallback? onAnimEnd) {
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

  Future<void> onFooterLoadFinished() async {
    notifier.value += 0.1; // 更新UI
    // 在次状态停顿200毫秒后隐藏头部，恢复下拉加载状态
    await Future.delayed(const Duration(milliseconds: 260));
    if (widget.headerFnc == RefresherFunc.load_more && widget.controller.isNeedHeaderOffsetOnLoadFinished) {
      state.param.refreshFinishOffset = -state.param.headerHeight;
      notifier.value -= 0.1; // 更新UI
      state.sc.jumpTo(state.sc.offset + state.param.headerTriggerRefreshDistance);
    }
    await Future.delayed(const Duration(milliseconds: 40));
    animUpdateFooter();
  }

  void animUpdateFooter() {
    if (state.stateManager.curRefreshState == RefreshState.header_loading) {
      anim.update(-(state.param.headerHeight - state.param.headerTriggerRefreshDistance), begin: notifier.value);
    } else if (state.stateManager.curRefreshState == RefreshState.header_load_finished) {
      anim.update(-state.param.headerHeight, begin: notifier.value);
    } else {
      anim.update(-state.param.headerHeight, begin: notifier.value);
    }
    anim.controller.forward(from: 0);
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
    return state.stateManager.curRefreshState == RefreshState.footer_loading ||
        state.stateManager.curRefreshState == RefreshState.footer_load_finished;
  }
}
