import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/Log.dart';
import 'scrollable_positioned_list_my.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart' as pos_list;

import 'dart:math' as math;
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
  double headerHeight = refresherParam.headerOrFooterHeight;
  double resetPos = refresherParam.headerOrFooterHeight;
  double footerHeight = refresherParam.headerOrFooterHeight;
  late ScrollController sc = ScrollController(initialScrollOffset: headerHeight);
  final HeaderWidgetBuilder headerBuilder = HeaderWidgetBuilder();
  final FooterWidgetBuilder footerWidgetBuilder = FooterWidgetBuilder();
  final isProhibitListViewScroll = false.obs;
  final curRefreshState = RefreshState.def.obs;
  int oriDataListSize = 0;

  @override
  void initState() {
    widget.refresherController.attach(this);
    oriDataListSize = widget.dataList.length;
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
          SizedBox(
            width: maxWidth,
            height: maxHeight,
            child: Listener(
              onPointerUp: onPointerUp,
              onPointerDown: onPointerDown,
              onPointerMove: onPointerMove,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  switch (notification.runtimeType) {
                    case ScrollStartNotification:
                      // Log.d("开始滚动");
                      break;
                    case ScrollUpdateNotification:
                      //  Log.d("正在滚动");
                      break;
                    case ScrollEndNotification:
                      //  Log.d("滚动停止");
                      break;
                    case OverscrollNotification:
                      if (!isProhibitScroll) {
                        handleEdgeFling(notification);
                      }
                      // Log.d("滚动到边界 velocity:$velocity");
                      break;
                  }
                  return true;
                },
                child: ValueListenableBuilder(
                    valueListenable: widget.refresherController.dataChangedNotifier,
                    builder: (c, data, child) {
                      Log.d("length: ${widget.dataList.length} child:$child");
                      return ScrollablePositionedList.builder(
                        physics: const ClampingScrollPhysics(),
                        itemScrollController: widget.itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                        initialScrollIndex: 0,
                        itemBuilder: widget.itemBuilder,
                        reverse: widget.isReverse,
                        itemCount: widget.dataList.length,
                        // minCacheExtent: 1920 * 2,
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

  Future<void> handleEdgeFling(ScrollNotification notification) async {
    OverscrollNotification os = notification as OverscrollNotification;
    double velocity = os.velocity;

    /// 延迟大约一帧的时间， 使ListView滚到到位
    await Future.delayed(const Duration(milliseconds: 20));
    if (velocity != 0) {
      scrollShowingHeaderByFlingVelocity(velocity, maxVelocity: 10000);
    }
  }

  bool checkIsToTop() {
    List<pos_list.ItemPosition> itemViewList = itemPositionsListener.itemPositions.value.toList();
    if (widget.isReverse) {
      /// reverse模式下：itemLeadingEdge 是item底部到ListView底部的距离相对于ListView视口高度的百分比，在ListView的底部下方为负数，上方为正数
      ///              itemTrailingEdge 是item顶部到ListView底部的距离相对于ListView视口高度的百分比，在ListView的底部下方为负数，上方为正数
      ///              故，此模式下，当 itemTrailingEdge <= 1的时候，表示item顶部处于ListView的Viewport范围
      for (var element in itemViewList) {
        //Log.d("==000===index: ${element.index} itemLeadingEdge ${element.itemLeadingEdge}  itemTrailingEdge ${element.itemTrailingEdge}");
        if (element.index == widget.dataList.length - 1) {
          // Log.d("==111===index: ${element.index} itemLeadingEdge ${element.itemLeadingEdge}  itemTrailingEdge ${element.itemTrailingEdge}");
          if (element.itemTrailingEdge <= 1.01) {
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

  bool checkIsToBotOnMove() {
    List<pos_list.ItemPosition> itemViewList = itemPositionsListener.itemPositions.value.toList();
    if (widget.isReverse) {
      /// reverse模式下：itemLeadingEdge 是item底部到ListView底部的距离相对于ListView视口高度的百分比，在ListView的底部下方为负数，上方为正数
      ///              itemTrailingEdge 是item顶部到ListView底部的距离相对于ListView视口高度的百分比，在ListView的底部下方为负数，上方为正数
      ///              故，此模式下，当 itemTrailingEdge > 0 && itemTrailingEdge <= 1的时候，表示item顶部处于ListView的Viewport范围
      for (var element in itemViewList) {
        //  Log.d("==000===index: ${element.index} itemLeadingEdge ${element.itemLeadingEdge}  itemTrailingEdge ${element.itemTrailingEdge}");
        if (element.index == 0) {
          // Log.d("==111===index: ${element.index} itemLeadingEdge ${element.itemLeadingEdge}  itemTrailingEdge ${element.itemTrailingEdge}");
          if (element.itemTrailingEdge >= 0) {
            return true;
          }
        }
      }
    } else {
      /// 非reverse模式下：itemLeadingEdge 是item顶部到ListView顶部的距离相对于ListView视口高度的百分比，在ListView的底部下方为正数，上方为负数
      ///              故，此模式下，当 itemLeadingEdge >= 0 && itemLeadingEdge < 1的时候，表示item顶部处于ListView的Viewport范围
      for (var element in itemViewList) {
        if (element.index == widget.dataList.length - 1) {
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

  bool footerIsShowing() {
    return sc.position.pixels > headerHeight;
  }

  void offsetHeaderOrFooter(double delta, bool isToTopEdge, bool isToBotOnMove) {
    double scrolledY = getScrolledYToResetPos().abs();
    double scrolledRatio = scrolledY / headerHeight;
    double tarScrollDy = 0;

    /// 怎么判断头或者脚滑出  delta > 0 像下滑出
    if (delta > 0 && headerIsShowing() || delta < 0 && footerIsShowing()) {
      tarScrollDy = sc.position.pixels - (delta * math.pow((1 - scrolledRatio), 2));
    } else {
      tarScrollDy = sc.position.pixels - delta;
    }

    bool headerScrollCon = tarScrollDy < headerHeight && isToTopEdge;
    bool footerScrollCon = tarScrollDy > headerHeight && isToBotOnMove;
    if (headerScrollCon || footerScrollCon) {
      sc.position.jumpTo(tarScrollDy);
    }
  }

  /// 只处理释放刷加载和默认状态
  void updateHeaderState() {
    if (headerIsShowing()) {
      if (isTouchScrollStateOfHeader()) {
        if (sc.position.pixels <= refresherParam.loadingPosOfHeader) {
          curRefreshState.value = RefreshState.header_release_load;
        } else {
          curRefreshState.value = RefreshState.def;
        }
      }
    } else if (footerIsShowing()) {
      if (isTouchScrollStateOfFooter()) {
        if (sc.position.pixels >= refresherParam.loadingPosOfFooter) {
          curRefreshState.value = RefreshState.footer_release_load;
        } else if (sc.position.pixels > refresherParam.loadingPosOfHeader) {
          curRefreshState.value = RefreshState.def;
        }
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
    var scrolledYToResetPos = getScrolledYToResetPos();
    if (scrolledYToResetPos.abs() > 0) {
      if (isAllDataLoadFinishedState()) {
        animToResetPos();
      } else {
        if (scrolledYToResetPos <= -refresherParam.headerIndicatorHeight && checkIsToTop()) {
          animToLoadingPos(refresherParam.loadingPosOfHeader, RefreshState.header_loading);
        } else if (scrolledYToResetPos >= refresherParam.footerIndicatorHeight) {
          animToLoadingPos(refresherParam.loadingPosOfFooter, RefreshState.footer_loading);
        } else {
          animToResetPos();
        }
      }
    }
  }

  bool isTouchScrollStateOfHeader() {
    return curRefreshState.value == RefreshState.def || curRefreshState.value == RefreshState.header_release_load;
  }

  bool isTouchScrollStateOfFooter() {
    return curRefreshState.value == RefreshState.def || curRefreshState.value == RefreshState.footer_release_load;
  }

  /// 所有数据加载完成，没有更多数据了
  bool isAllDataLoadFinishedState() {
    return curRefreshState.value == RefreshState.all_data_load_finished;
  }

  bool isHandScrollListViewOnHeaderShow = false;
  bool isProhibitScroll = false;

  void onPointerMove(PointerMoveEvent e) {
    if (isProhibitScroll) {
      return;
    }
    bool isToTopEdge = checkIsToTop();
    var isToBotOnMove = checkIsToBotOnMove();
    handleListViewScrollOnMoving(e, isToTopEdge, isToBotOnMove);
    // Log.d("isToTopEdge: $isToTopEdge isReverse:${widget.isReverse}  isToBotOnMove:$isToBotOnMove");
    if (isToTopEdge || isToBotOnMove) {
      offsetHeaderOrFooter(e.delta.dy, isToTopEdge, isToBotOnMove);
    }
  }

  void handleListViewScrollOnMoving(PointerMoveEvent e, bool isToTopEdge, bool isToBotOnMove) {
    var isHeaderShowing = headerIsShowing();
    var isFooterShowing = footerIsShowing();
    if (isHeaderShowing || isFooterShowing) {
      isHandScrollListViewOnHeaderShow = true;
    }
    if (isHandScrollListViewOnHeaderShow && getListScrollController() != null) {
      if (isHeaderShowing && isToTopEdge) {
        double scrolledPosOnHeaderShow = widget.isReverse ? getListScrollController()!.position.maxScrollExtent : 0;
        getListScrollController()!.jumpTo(scrolledPosOnHeaderShow);
      } else if (isFooterShowing && isToBotOnMove) {
        double scrolledPosOnFooterShow = widget.isReverse ? 0 : getListScrollController()!.position.maxScrollExtent;
        getListScrollController()!.jumpTo(scrolledPosOnFooterShow);
      } else {
        double scrolledPos = getListScrollController()!.offset + (widget.isReverse ? e.delta.dy : -e.delta.dy);
        getListScrollController()!.jumpTo(scrolledPos);
      }
    }
  }

  Future<void> animToResetPos({isOffsetShowingMoreData = false, isNotifyLoadFinish = false, during = 250}) async {
    sc.animateTo(headerHeight, duration: Duration(milliseconds: during), curve: Curves.easeInSine).then((value) async {
      /// 加载更多结束后 偏移显示出新数据
      if (isOffsetShowingMoreData) {
        var listScrollController = getListScrollController();
        if (listScrollController != null) {
          var offset = listScrollController.offset;

          /// 怎么确定是头部加载更多 还是脚部加载更多
          if (curRefreshState.value == RefreshState.header_load_finished) {
            listScrollController.jumpTo(offset + refresherParam.headerIndicatorHeight);
          } else if (curRefreshState.value == RefreshState.footer_load_finished) {
            listScrollController.jumpTo(offset - refresherParam.headerIndicatorHeight);
          } else {
            Log.e("非法状态-不是加载完成状态");
          }
        }
      }
      if (isNotifyLoadFinish) {
        await Future.delayed(const Duration(milliseconds: 20));
        curRefreshState.value = RefreshState.def;
      }
      if (widget.refresherController.isNoNewDataOnLoadMore) {
        curRefreshState.value = RefreshState.all_data_load_finished;
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

  void notifyDataChanged() {
    widget.refresherController.dataChangedNotifier.value++;
  }

  Future<void> notifyLoadingFinish({bool isOffsetShowNewData = false}) async {
    RefreshState tarFinishedState = RefreshState.def;
    if (curRefreshState.value == RefreshState.header_loading) {
      tarFinishedState = RefreshState.header_load_finished;
    } else if (curRefreshState.value == RefreshState.footer_loading) {
      tarFinishedState = RefreshState.footer_load_finished;
    } else {
      Log.e("非法状态-当前不是正在加载状态...");
    }
    curRefreshState.value = tarFinishedState;
    widget.refresherController.dataChangedNotifier.value++;
    await Future.delayed(const Duration(milliseconds: 150));

    /// 如果是加载更多 并且有新的数据
    bool isOffsetShowingMoreData = isOffsetShowNewData && widget.dataList.length > oriDataListSize;
    int during = isOffsetShowingMoreData ? 1 : 250;
    animToResetPos(isOffsetShowingMoreData: isOffsetShowingMoreData, isNotifyLoadFinish: true, during: during);
    oriDataListSize = widget.dataList.length;
  }

  Future<void> animToLoadingPos(double tarY, RefreshState tarState) async {
    var rate = (tarY - sc.offset).abs() / refresherParam.maxScrollDistanceToLoading;
    int during = 100 + (rate * 200).toInt();
    sc.animateTo(tarY, duration: Duration(milliseconds: during), curve: Curves.easeInSine).then((value) async {
      /// 加上sc.offset == refresherParam.loadingPos 可能发生动画未执行完成就被挤掉导致回调
      if (isTouchScrollStateOfHeader() && sc.offset == tarY) {
        curRefreshState.value = tarState;
        await Future.delayed(const Duration(milliseconds: 100));
        widget.onHeaderStartLoad();
      } else if (isTouchScrollStateOfFooter() && sc.offset == tarY) {
        curRefreshState.value = tarState;
        await Future.delayed(const Duration(milliseconds: 100));
        widget.onFooterStartLoad();
        autoCloseRefresh();
      }
    });
  }

  Future<void> autoCloseRefresh() async {
    await Future.delayed(const Duration(milliseconds: 250));

    /// 因为是自动结束加载，故不好判断数据是否加载完毕，也不好确定是否加载更多
    notifyLoadingFinish(isOffsetShowNewData: false);
  }

  Future<void> scrollShowingHeaderByFlingVelocity(double velocity, {maxVelocity = 12000}) async {
    // 0-velocity 转成 => 0-1
    velocity = velocity.abs() > maxVelocity ? maxVelocity : velocity.abs();
    late double showingHeaderHeight = refresherParam.headerOrFooterHeight * velocity / maxVelocity;
    int during = 100 + (showingHeaderHeight.abs() / refresherParam.headerOrFooterHeight * 200).toInt();
    var isToTop = checkIsToTop();
    int dir = isToTop ? -1 : 1;
    double tarPos = sc.offset + showingHeaderHeight * dir;
    sc.animateTo(tarPos, duration: Duration(milliseconds: during), curve: Curves.decelerate).then((value) {
      if (!isPressing) {
        toNextStateOnHeaderShowing();
      }
    });
  }

  /// 获取滚出头部或者脚部的高度
  double getScrolledYToResetPos() {
    return sc.position.pixels - headerHeight;
  }

  double getScrolledHeaderY() {
    if (sc.position.pixels >= 0 && sc.position.pixels < headerHeight) {
      return headerHeight - sc.position.pixels;
    }
    return 0;
  }

  double getScrolledFooterY() {
    if (sc.position.pixels > headerHeight) {
      return sc.position.pixels - headerHeight;
    }
    return 0;
  }
}

class RefresherController {
  MyRefreshState? myRefreshState;
  final ValueNotifier<int> dataChangedNotifier = ValueNotifier<int>(0);

  void notifyDataChanged() {
    if (myRefreshState != null) {
      myRefreshState!.notifyDataChanged();
    }
  }

  void attach(MyRefreshState state) {
    myRefreshState = state;
  }

  bool isNoNewDataOnLoadMore = false;

  void notifyLoadFinish({isNoNewDataOnLoadMore = false, bool isOffsetShowNewData = false}) {
    this.isNoNewDataOnLoadMore = isNoNewDataOnLoadMore;
    if (myRefreshState != null) {
      myRefreshState!.notifyLoadingFinish(isOffsetShowNewData: isOffsetShowNewData);
    }
  }
}
