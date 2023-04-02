import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../util/Log.dart';


typedef OnScrollToEndListener = void Function();

class MarqueeHelper {
  late AnimationController animController;
  OnScrollToEndListener? onScrollToEndListener;

  MarqueeHelper({required TickerProvider vsync}) {
    animController = AnimationController(vsync: vsync, duration: Duration(seconds: 60 * 5))..forward();
  }

  void setOnScrollToEndListener(OnScrollToEndListener listener) {
    onScrollToEndListener = listener;
  }

  late double lastMaxScrollExtent;
  double lastScrollPos = 0;
  double lastScrolledAnimValue = 0;
  double lastScrolledAnimDistanceValue = 0;

  final ScrollController sc = ScrollController();

  // 从头部开始滚动的开始时间戳
  int startTimeStampOnStart = 0;

  void setUpMarquee() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(Duration(milliseconds: 1000), (timer) {
        if (sc.hasClients) {
          if (sc.position.maxScrollExtent > 0) {
            startTimeStampOnStart = DateTime.now().millisecondsSinceEpoch; // 时间戳
            lastMaxScrollExtent = sc.position.maxScrollExtent;
            startScrollStrategy1();
            timer.cancel();
          }
        }
      });
    });
  }

  void startScrollStrategy1() {
    animController.addListener(() {
      /// 如果maxScrollExtent 滚动过程连续动态变化 可能会闪烁，需要进行值的转化
      /// 能滚动的最大长度发生了变化
      if (lastMaxScrollExtent != sc.position.maxScrollExtent) {
        lastMaxScrollExtent = sc.position.maxScrollExtent;
        if (lastScrollPos < sc.position.maxScrollExtent) {
          /// 从上次滚动的地方开始滚动
          double lastScrollRatio = lastScrollPos / sc.position.maxScrollExtent;
          // lastScrollRatio = lastScrollRatio + lastScrolledAnimDistanceValue;
          // Log.d("lastScrollRatio: $lastScrollRatio ${getCurCostTime()}");
          animController.stop();
          animController.forward(from: lastScrollRatio);
          return;
        } else {
          /// 已经滚动的长度大于等于最新能滚动的长度， 重新开始滚动
          reScroll();
          return;
        }
      }
      var tarScrollingPos = animController.value * sc.position.maxScrollExtent;
      sc.jumpTo(tarScrollingPos);
      lastScrollPos = tarScrollingPos;
      lastScrolledAnimDistanceValue = animController.value - lastScrolledAnimValue;
      lastScrolledAnimValue = animController.value;
      // Log.d("lastScrolledAnimDistanceValue:  $lastScrolledAnimDistanceValue");
      if (tarScrollingPos == sc.position.maxScrollExtent) {
        if (onScrollToEndListener != null) {
          onScrollToEndListener!();
        }
        reScroll();
      }
    });
  }

  void reScroll() {
    animController.forward(from: 0);
    int costTime = (DateTime.now().millisecondsSinceEpoch - startTimeStampOnStart) ~/ 1000;
    Log.d("跑马灯执行完一个流程的动画： 花费时间：$costTime 秒");
    startTimeStampOnStart = DateTime.now().millisecondsSinceEpoch; // 时间戳
  }

  String getCurCostTime() {
    int costTime = (DateTime.now().millisecondsSinceEpoch - startTimeStampOnStart) ~/ 1000;
    return "花费时间：$costTime 秒";
  }

  /// 滚动速度受回调速度的影响： 每次滚动固定的长度
  void startScrollStrategy2() {
    animController.addListener(() {
      var tarScrollingPos = lastScrollPos + 2;
      if (tarScrollingPos > sc.position.maxScrollExtent) {
        tarScrollingPos = sc.position.maxScrollExtent;
      }
      sc.jumpTo(tarScrollingPos);
      lastScrollPos = tarScrollingPos;
      if (tarScrollingPos == sc.position.maxScrollExtent) {
        reScroll();
      }
    });
  }

  void dispose() {
    animController.dispose();
  }
}
