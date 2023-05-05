import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_lib_3/my_widgets/scrollable_pos_list/scrollable_positioned_list_my.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart' as pos_list;

import 'dart:math' as math;
import '../../util/Log.dart';
import 'footer_indicator_widget.dart';
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
  pos_list.ItemPositionsListener itemPositionsListener = pos_list.ItemPositionsListener.create();
  double headerHeight = refresherParam.headerHeight;
  double resetPos = refresherParam.headerHeight;
  double footerHeight = refresherParam.footerHeight;
  late ScrollController sc = ScrollController(initialScrollOffset: headerHeight);
  final HeaderWidgetBuilder headerBuilder = HeaderWidgetBuilder();
  final FooterWidgetBuilder footerWidgetBuilder = FooterWidgetBuilder();
  final isProhibitListViewScroll = false.obs;
  final curRefreshState = RefreshState.def.obs;

  @override
  void initState() {
    widget.refresherController.attach(this);
    super.initState();
    sc.addListener(() {
      updateHeaderState();
    });
  }

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
            alignment: Alignment.bottomCenter,
            child: Container(
              height: refresherParam.headerIndicatorHeight,
              width: double.infinity,
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
              onPointerDown: onPointerDown,
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
                      if (velocity > 0 && widget.isReverse) {
                        // header加载更多
                        scrollShowingHeaderByFlingVelocity(velocity, maxVelocity: 8000);
                      }
                      if (velocity < 0 && !widget.isReverse) {
                        // header刷新
                        scrollShowingHeaderByFlingVelocity(velocity, maxVelocity: 12000);
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
                      return ScrollablePositionedList.builder(
                        physics: const ClampingScrollPhysics(),
                        itemScrollController: widget.itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                        itemBuilder: widget.itemBuilder,
                        shrinkWrap: true,
                        reverse: widget.isReverse,
                        itemCount: widget.dataList.length,
                      );
                    }),
              ),
            ),
          ),
          Container(
            width: maxWidth,
            height: footerHeight,
            alignment: Alignment.topCenter,
            child: Container(
              height: refresherParam.footerIndicatorHeight,
              width: double.infinity,
              alignment: Alignment.center,
              child: Obx(() => footerWidgetBuilder.getFooterWidget(curRefreshState.value, RefresherFunc.refresh)),
            ),
          ),
        ],
      );
    });
  }

  bool checkIsToTopOnMove() {
    List<pos_list.ItemPosition> itemViewList = itemPositionsListener.itemPositions.value.toList();
    if (widget.isReverse) {
      /// reverse模式下：itemLeadingEdge 是item底部到ListView底部的距离相对于ListView视口高度的百分比，在ListView的底部下方为负数，上方为正数
      ///              itemTrailingEdge 是item顶部到ListView底部的距离相对于ListView视口高度的百分比，在ListView的底部下方为负数，上方为正数
      ///              故，此模式下，当 itemTrailingEdge > 0 && itemTrailingEdge <= 1的时候，表示item顶部处于ListView的Viewport范围
      for (var element in itemViewList) {
        if (element.index == widget.dataList.length - 1) {
          //  Log.d("index: ${element.index} itemLeadingEdge ${element.itemLeadingEdge}  itemTrailingEdge ${element.itemTrailingEdge}");
          if (element.itemTrailingEdge > 0 && element.itemTrailingEdge <= 1.01) {
            return true;
          }
        }
      }
    } else {
      /// 非reverse模式下：itemLeadingEdge 是item顶部到ListView顶部的距离相对于ListView视口高度的百分比，在ListView的底部下方为正数，上方为负数
      ///              故，此模式下，当 itemLeadingEdge >= 0 && itemLeadingEdge < 1的时候，表示item顶部处于ListView的Viewport范围
      for (var element in itemViewList) {
        if (element.index == 0) {
          //  Log.d("index: ${element.index} itemLeadingEdge ${element.itemLeadingEdge}  itemTrailingEdge ${element.itemTrailingEdge}");
          if (element.itemLeadingEdge >= -0.01 && element.itemLeadingEdge < 1) {
            return true;
          }
        }
      }
    }
    if (itemViewList.isEmpty) {
      return true;
    }
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
  }

  void updateHeaderState() {
    if (!isHeaderProtectionState()) {
      if (sc.position.pixels < refresherParam.loadingPos) {
        curRefreshState.value = RefreshState.header_release_load;
      } else if (sc.position.pixels > refresherParam.loadingPos) {
        curRefreshState.value = RefreshState.def;
      }
    }
  }

  bool isPressing = false;

  void onPointerUp(PointerUpEvent event) {
    isPressing = false;
    isHandScrollListViewOnHeaderShow = false;
    toNextStateOnHeaderShowing();
  }

  void onPointerDown(PointerDownEvent event) {
    isPressing = true;
  }

  void toNextStateOnHeaderShowing() {
    if (headerIsShowing()) {
      var scrolledHeaderY = getScrolledHeaderY();
      if (scrolledHeaderY >= refresherParam.headerTriggerRefreshDistance) {
        animToHeaderLoadingPos();
      } else {
        animToResetPos();
      }
    }
  }

  bool isHeaderProtectionState() {
    return curRefreshState.value == RefreshState.header_loading || curRefreshState.value == RefreshState.header_load_finished;
  }

  bool isHandScrollListViewOnHeaderShow = false;

  void onPointerMove(PointerMoveEvent e) {
    var isHeaderShowing = headerIsShowing();
    if (isHeaderShowing) {
      isHandScrollListViewOnHeaderShow = true;
    }
    if (isHandScrollListViewOnHeaderShow) {
      double headPos = widget.isReverse ? getListScrollController()?.position.maxScrollExtent ?? 0 : 0;
      double scrolledPos = getListScrollController()!.offset + (widget.isReverse ? e.delta.dy : -e.delta.dy);
      getListScrollController()?.jumpTo(isHeaderShowing ? headPos : scrolledPos);
    }
    bool isToTopEdge = checkIsToTopOnMove();
    bool headerShowing = headerIsShowing();
    if (isToTopEdge || headerShowing) {
      offsetHeader(e.delta.dy);
    }
  }

  Future<void> animToResetPos({isLoadFinished = false, during = 250}) async {
    sc.animateTo(headerHeight, duration: Duration(milliseconds: during), curve: Curves.easeInSine).then((value) async {
      /// 加载更多结束后 偏移显示出新数据
      if (isLoadFinished && during < 10) {
        ScrollablePositionedListState? state = widget.itemScrollController.getState();
        if (state != null) {
          var offset = state.primary.scrollController.offset;
          state.primary.scrollController.jumpTo(refresherParam.headerTriggerRefreshDistance + offset);
        }
      }
      if (!isHeaderProtectionState() || isLoadFinished) {
        await Future.delayed(const Duration(milliseconds: 20));
        curRefreshState.value = RefreshState.def;
      }
    });
  }

  ScrollController? getListScrollController() {
    ScrollablePositionedListState? state = widget.itemScrollController.getState();
    if (state != null) {
      return state.primary.scrollController;
    }
    return null;
  }

  Future<void> notifyHeaderLoadingFinish() async {
    curRefreshState.value = RefreshState.header_load_finished;
    widget.refresherController.dataChangedNotifier.value++;
    await Future.delayed(const Duration(milliseconds: 150));
    int during = widget.isReverse ? 1 : 250;
    animToResetPos(isLoadFinished: true, during: during);
  }

  Future<void> animToHeaderLoadingPos() async {
    var rate = (refresherParam.loadingPos - sc.offset).abs() / refresherParam.headerToLoadingMaxDistance;
    int during = 100 + (rate * 200).toInt();
    sc.animateTo(refresherParam.loadingPos, duration: Duration(milliseconds: during), curve: Curves.easeInSine).then((value) async {
      /// 加上sc.offset == refresherParam.loadingPos 可能发生动画未执行完成就被挤掉导致回调
      if (!isHeaderProtectionState() && sc.offset == refresherParam.loadingPos) {
        curRefreshState.value = RefreshState.header_loading;
        await Future.delayed(const Duration(milliseconds: 100));
        widget.onHeaderStartLoad();
      }
    });
  }

  Future<void> scrollShowingHeaderByFlingVelocity(double velocity, {maxVelocity = 12000}) async {
    // 0-velocity 转成 => 0-1
    velocity = velocity.abs() > maxVelocity ? maxVelocity : velocity.abs();
    late double showingHeaderHeight = refresherParam.headerHeight * velocity / maxVelocity;
    int during = 100 + (showingHeaderHeight.abs() / refresherParam.headerHeight * 200).toInt();
    sc.animateTo(sc.offset - showingHeaderHeight, duration: Duration(milliseconds: during), curve: Curves.decelerate).then((value) {
      if (!isPressing) {
        toNextStateOnHeaderShowing();
      }
    });
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
