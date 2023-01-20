import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresh_state.dart';

import '../../util/Log.dart';
import '../comm_anim2.dart';
import '../my_physics.dart';
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
    required this.onRefresh,
    required this.onLoadMore,
  });

  final Widget child;
  final ScrollController sc;
  final double height;
  final double width;
  final OnRefresh onRefresh;
  final OnLoadMore onLoadMore;

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

  void onAnimUpdate() {
    notifier.value = anim.animation?.value ?? -headerHeight;
    if (anim.controller.isCompleted && state != 1) {
      state = 1;
      if (curRefreshState == RefreshState.refresh_finished) {
        updateState(getScrolledHeaderY(), 4);
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

  ///  offset: Offset(0, notifier.value),
  Widget _buildContent() {
    return ClipRRect(
      child: Transform.translate(
        offset: Offset(0, notifier.value),
        child: Column(
          children: [
            _buildHeader(),
            Listener(
              onPointerMove: onPointerMove,
              onPointerUp: onPointerUp,
              onPointerCancel: onPointerCancel,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }

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
            child: getHeaderWidget(curRefreshState),
          ),
        ],
      ),
    );
  }

  double max = 0;
  double min = double.maxFinite;
  double pixels = 0;

  void onPointerUp(PointerUpEvent event) {
    if (max > 0 && pixels >= max && notifier.value > -headerHeight) {
      // 释放刷新 => 正在刷新 或下拉刷新状态不变，回到隐藏头
      updateState(getScrolledHeaderY(), 2);
      animUpdateHeader();
    } else {
      Log.d("头部收回动画条件不满足：");
    }
  }

  void animUpdateHeader() {
    if (curRefreshState == RefreshState.refreshing) {
      anim.update(-(headerHeight - headerTriggerRefreshDistance), begin: notifier.value);
    } else if (curRefreshState == RefreshState.refresh_finished) {
      anim.update(-headerHeight, begin: notifier.value);
    } else {
      anim.update(-headerHeight, begin: notifier.value);
    }
    anim.controller.forward(from: 0);
  }

  double getScrolledHeaderY() {
    return headerHeight + notifier.value;
  }

  void onPointerCancel(PointerCancelEvent event) {
    Log.d("========onPointerCancel======：");
  }

  RefreshState curRefreshState = RefreshState.pull_down_refresh;

  void onPointerMove(PointerMoveEvent e) {
    ScrollPosition position = sc.position;
    max = position.maxScrollExtent;
    min = position.minScrollExtent;
    pixels = position.pixels;
    double newValue = notifier.value + e.delta.dy;
    MyClampingScrollPhysics physics = sc.position.physics as MyClampingScrollPhysics;
    //header scroll
    if (headerIsHidden()) {
      physics.scrollEnable = true;
    } else {
      physics.scrollEnable = false;
    }
    if (pixels >= max) {
      double scrolledHeaderY = getScrolledHeaderY();
      if (e.delta.dy > 0) {
        // header 向下滑动

        double scrolledRate = scrolledHeaderY / headerHeight;
        newValue = notifier.value + (e.delta.dy * (1 - scrolledRate));
        if (newValue > 0) newValue = 0;
        notifier.value = newValue;
        //  Log.d("header 向下滑动 越界滑动状态 :  ${e.delta}  max:$max   pixels:$pixels  newValue:$newValue  rate:$scrolledRate");
      } else if (e.delta.dy < 0) {
        // header 向上滑动
        if (newValue < -headerHeight) newValue = -headerHeight;
        notifier.value = newValue;
        // Log.d("header 向上滑动 :  ${e.delta}  max:$max   min:$min  newValue:$newValue");
      }
      //头部触摸移动只有两种状态切换（下拉刷新，释放刷新）
      updateState(scrolledHeaderY, 1);
    } else if (pixels <= min) {}
    // Log.d("pixels:$pixels  max:$max ");
  }

  bool headerIsHidden() {
    return notifier.value <= -headerHeight;
  }

  Future<void> updateState(double scrolledHeaderY, int switchType) async {
    if (switchType == 1 && curRefreshState != RefreshState.refreshing) {
      if (scrolledHeaderY >= headerTriggerRefreshDistance) {
        curRefreshState = RefreshState.release_refresh;
      } else {
        curRefreshState = RefreshState.pull_down_refresh;
      }
    } else if (switchType == 2) {
      // 释放刷新 => 正在刷新 或下拉刷新状态不变，动画隐藏头
      if (curRefreshState == RefreshState.release_refresh) {
        curRefreshState = RefreshState.refreshing;
        widget.onRefresh(this);
      }
    } else if (switchType == 3) {
      // 正在刷新->刷新结束
      if (curRefreshState == RefreshState.refreshing) {
        curRefreshState = RefreshState.refresh_finished;
        notifier.value += 0.1; // 更新UI
        // 在次状态停顿200毫秒后隐藏头部，恢复下拉刷新状态
        await Future.delayed(const Duration(milliseconds: 300));
        animUpdateHeader();
      }
    } else if (switchType == 4) {
      // 刷新结束 -> 下拉刷新
      if (curRefreshState == RefreshState.refresh_finished) {
        curRefreshState = RefreshState.pull_down_refresh;
      }
    }
  }

  void notifyRefreshFinish() {
    //  正在刷新->刷新结束
    updateState(getScrolledHeaderY(), 3);
  }
}
