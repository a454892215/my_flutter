import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'dart:math' as math;
import '../../util/Log.dart';
import 'header_indicator_widget.dart';
import 'refresh_state.dart';
import 'refresher_param.dart';

typedef OnHeaderStartLoad = void Function();
typedef OnFooterStartLoad = void Function();

class RefresherIndexListWidget extends StatefulWidget {
  const RefresherIndexListWidget({
    Key? key,
    required this.itemBuilder,
    required this.dataList,
    required this.itemScrollController,
    required this.refresherController,
    required this.onHeaderStartLoad,
    required this.onFooterStartLoad,
    this.isReverse = true,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final List dataList;
  final ItemScrollController itemScrollController;
  final RefresherController refresherController;
  final OnHeaderStartLoad onHeaderStartLoad;
  final OnFooterStartLoad onFooterStartLoad;
  final bool isReverse;

  @override
  State<StatefulWidget> createState() {
    return MyRefreshState();
  }
}

RefresherParam refresherParam = RefresherParam();

class MyRefreshState extends State<RefresherIndexListWidget> {
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  double headerHeight = refresherParam.headerHeight;
  double footerHeight = refresherParam.footerHeight;
  late ScrollController sc = ScrollController(initialScrollOffset: headerHeight);
  final HeaderWidgetBuilder headerBuilder = HeaderWidgetBuilder();
  final isProhibitListViewScroll = false.obs;
  final curRefreshState = RefreshState.def.obs;

  @override
  void initState() {
    widget.refresherController.attach(this);
    super.initState();
  }

  final isProhibitScroll = false.obs;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (c, b) {
      var maxWidth = b.maxWidth;
      var maxHeight = b.maxHeight;
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        controller: sc,
        children: [
          Container(
            width: maxWidth,
            height: headerHeight,
            color: Colors.blue,
            alignment: Alignment.bottomCenter,
            child: Container(
              height: refresherParam.headerIndicatorHeight,
              width: double.infinity,
              color: Colors.orange,
              alignment: Alignment.center,
              child: Obx(() => headerBuilder.getHeaderWidget(curRefreshState.value, RefresherFunc.refresh)),
            ),
          ),
          Container(
            width: maxWidth,
            height: maxHeight,
            color: Colors.pink,
            child: Listener(
              onPointerUp: onPointerUp,
              onPointerMove: onPointerMove,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  switch (notification.runtimeType) {
                    case ScrollStartNotification:
                      Log.d("开始滚动");
                      break;
                    case ScrollUpdateNotification:
                      //  Log.d("正在滚动");
                      break;
                    case ScrollEndNotification:
                      Log.d("滚动停止");
                      break;
                    case OverscrollNotification:
                      OverscrollNotification os = notification as OverscrollNotification;
                      double velocity = os.velocity;
                      if (velocity > 0) {
                        animToHeaderLoadingPos(during: 200);
                      }
                      Log.d("滚动到边界 velocity:$velocity");
                      break;
                  }
                  return true;
                },
                child: ValueListenableBuilder(
                    valueListenable: widget.refresherController.dataChangedNotifier,
                    builder: (c, data, child) {
                      Log.d("length: ${widget.dataList.length}");
                      return Obx(() => ScrollablePositionedList.builder(
                            physics: isProhibitScroll.value ? const NeverScrollableScrollPhysics() : const ClampingScrollPhysics(),
                            itemScrollController: widget.itemScrollController,
                            itemPositionsListener: itemPositionsListener,
                            itemBuilder: widget.itemBuilder,
                            shrinkWrap: true,
                            reverse: widget.isReverse,
                            itemCount: widget.dataList.length,
                          ));
                    }),
              ),
            ),
          ),
          Container(
            width: 1.sw,
            height: footerHeight,
            alignment: Alignment.center,
            color: Colors.purple,
          ),
        ],
      );
    });
  }

  bool checkIsToTopOnMove() {
    List<ItemPosition> itemViewList = itemPositionsListener.itemPositions.value.toList();
    if (widget.isReverse) {
      /// reverse模式下：itemLeadingEdge 是item底部到ListView底部的距离相对于ListView视口高度的百分比，在ListView的底部下方为负数，上方为正数
      ///              itemTrailingEdge 是item顶部到ListView底部的距离相对于ListView视口高度的百分比，在ListView的底部下方为负数，上方为正数
      ///              故，此模式下，当 itemTrailingEdge > 0 && itemTrailingEdge <= 1的时候，表示item顶部处于ListView的Viewport范围
      for (var element in itemViewList) {
        if (element.index == widget.dataList.length - 1) {
          Log.d("index: ${element.index} itemLeadingEdge ${element.itemLeadingEdge}  itemTrailingEdge ${element.itemTrailingEdge}");
          if (element.itemTrailingEdge > 0 && element.itemTrailingEdge <= 1.01) {
            return true;
          }
        }
      }
    } else {
      /// 非reverse模式下：itemLeadingEdge 是item顶部到ListView顶部的距离相对于ListView视口高度的百分比，在ListView的底部下方为负数，上方为正数
      ///              itemTrailingEdge 是item顶部到ListView底部的距离相对于ListView视口高度的百分比，在ListView的底部下方为负数，上方为正数
      ///              故，此模式下，当 itemTrailingEdge > 0 && itemTrailingEdge <= 1的时候，表示item顶部处于ListView的Viewport范围
      for (var element in itemViewList) {
        Log.d("index: ${element.index} itemLeadingEdge ${element.itemLeadingEdge}  itemTrailingEdge ${element.itemTrailingEdge}");
        if (element.index == 0) {
          return true;
        }
      }
    }
    return false;
  }

  bool canHeaderOffset() {
    return false;
  }

  bool canFooterOffset() {
    return false;
  }

  bool headerIsShowing() {
    return sc.position.pixels < headerHeight;
  }

  void offsetHeader(double delta) {
    double scrolledHeaderY = getScrolledHeaderY();
    double scrolledRatio = scrolledHeaderY / headerHeight;
    double tarScrollDy = 0;
    if (delta > 0) {
      tarScrollDy = sc.position.pixels - (delta * math.pow((1 - scrolledRatio), 2));
    } else {
      tarScrollDy = sc.position.pixels - delta;
    }
    if (tarScrollDy < 0) tarScrollDy = 0;
    if (tarScrollDy > headerHeight) tarScrollDy = headerHeight;
    sc.position.jumpTo(tarScrollDy);
    if (!isHeaderProtectionState()) {
      if (sc.position.pixels < refresherParam.loadingPos) {
        curRefreshState.value = RefreshState.header_release_load;
      } else if (sc.position.pixels > refresherParam.loadingPos) {
        curRefreshState.value = RefreshState.def;
      }
    }
  }

  onFooterOffset(double offset) {}

  void onPointerUp(PointerUpEvent event) {
    isProhibitScroll.value = false;
    if (headerIsShowing()) {
      var scrolledHeaderY = getScrolledHeaderY();
      if (scrolledHeaderY >= refresherParam.headerTriggerRefreshDistance) {
        animToHeaderLoadingPos();
      } else {
        animToDefPos();
      }
    }
  }

  bool isHeaderProtectionState() {
    return curRefreshState.value == RefreshState.header_loading || curRefreshState.value == RefreshState.header_load_finished;
  }

  void onPointerMove(PointerMoveEvent e) {
    isProhibitScroll.value = e.delta.dy > 0 && headerIsShowing();
    bool isToTopEdge = checkIsToTopOnMove();
    //  Log.d("isToTopEdge: $isToTopEdge   isProhibitScroll:$isProhibitScroll  向下滑动：${e.delta.dy > 0}");
    bool headerShowing = headerIsShowing();
    if (isToTopEdge || headerShowing) {
      offsetHeader(e.delta.dy);
    }
  }

  Future<void> animToDefPos({isDataUpdate = false, during = 250}) async {
    sc.animateTo(headerHeight, duration: Duration(milliseconds: during), curve: Curves.ease).then((value) {
      isProhibitScroll.value = false;
      widget.refresherController.dataChangedNotifier.value++;
    });
    if (!isHeaderProtectionState() || isDataUpdate) {
      await Future.delayed(const Duration(milliseconds: 50));
      Log.d("value: ===============animateTo=========222=========");
      curRefreshState.value = RefreshState.def;
    }
  }

  Future<void> notifyHeaderLoadingFinish() async {
    curRefreshState.value = RefreshState.header_load_finished;
    await Future.delayed(const Duration(milliseconds: 100));
    animToDefPos(isDataUpdate: true);
  }

  Future<void> animToHeaderLoadingPos({during = 200}) async {
    sc.animateTo(refresherParam.loadingPos, duration: Duration(milliseconds: during), curve: Curves.ease);
    if (!isHeaderProtectionState()) {
      curRefreshState.value = RefreshState.header_loading;
      await Future.delayed(Duration(milliseconds: during + 20));
      widget.onHeaderStartLoad();
    }
  }

  double getScrolledHeaderY() {
    if (sc.position.pixels >= 0 && sc.position.pixels < headerHeight) {
      return headerHeight - sc.position.pixels;
    }
    return 0;
  }
}

class RefresherController {
  MyRefreshState? myRefreshState;
  final ValueNotifier<int> dataChangedNotifier = ValueNotifier<int>(0);

  void attach(MyRefreshState state) {
    myRefreshState = state;
  }

  void notifyHeaderLoadFinish() {
    if (myRefreshState != null) {
      myRefreshState!.notifyHeaderLoadingFinish();
    }
  }
}

