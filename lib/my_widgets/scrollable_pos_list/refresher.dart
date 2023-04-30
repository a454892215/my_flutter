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
    required this.dataSize,
    required this.itemScrollController,
    required this.refresherController,
    required this.onHeaderStartLoad,
    required this.onFooterStartLoad,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final int dataSize;
  final ItemScrollController itemScrollController;
  final RefresherController refresherController;
  final OnHeaderStartLoad onHeaderStartLoad;
  final OnFooterStartLoad onFooterStartLoad;

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
  HeaderWidgetBuilder headerBuilder = HeaderWidgetBuilder();
  final isProhibitListViewScroll = false.obs;
  final ClampingScrollPhysics refresherPhysics = const ClampingScrollPhysics();

  final curRefreshState = RefreshState.def.obs;

  @override
  void initState() {
    widget.refresherController.attach(this);
    super.initState();
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
                      List<ItemPosition> itemViewList = itemPositionsListener.itemPositions.value.toList();
                      var isToTopEdge = itemViewList[0].index == 0;
                      if (isToTopEdge && velocity.abs() > 0) {
                        animToHeaderLoadingPos(during: 200);
                      }
                      Log.d("滚动到边界 velocity:$velocity  isToTopEdge:$isToTopEdge");
                      break;
                  }
                  return true;
                },
                child: ScrollablePositionedList.builder(
                  physics: refresherPhysics,
                  itemScrollController: widget.itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: widget.itemBuilder,
                  shrinkWrap: true,
                  itemCount: widget.dataSize,
                ),
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

  bool isScrollToTopEdge() {
    List<ItemPosition> itemViewList = itemPositionsListener.itemPositions.value.toList();
    bool isScrollToTopEdge = true;
    if (itemViewList.isNotEmpty) {
      ItemPosition item = itemViewList[0];
      var index = item.index;
      var itemLeadingEdge = item.itemLeadingEdge;
      // var itemTrailingEdge = item.itemTrailingEdge;
      isScrollToTopEdge = index == 0 && itemLeadingEdge >= 0;
      // Log.d(" index:$index  itemLeadingEdge:$itemLeadingEdge  itemTrailingEdge:$itemTrailingEdge delta:${e.delta} isToTopEdge:$isScrollToTopEdge");
    }
    return isScrollToTopEdge;
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

  onHeaderOffset(double delta) {
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
    bool isHasScrollToTopEdge = isScrollToTopEdge();
    bool headerShowing = headerIsShowing();
    if (isHasScrollToTopEdge || headerShowing) {
      onHeaderOffset(e.delta.dy);
    }
    if (headerShowing) {
      widget.itemScrollController.jumpTo(index: 0);
    }
  }

  Future<void> animToDefPos({isForceUpdate = false}) async {
    sc.animateTo(headerHeight, duration: const Duration(milliseconds: 250), curve: Curves.ease);
    if (!isHeaderProtectionState() || isForceUpdate) {
      await Future.delayed(const Duration(milliseconds: 250));
      curRefreshState.value = RefreshState.def;
    }
  }

  Future<void> notifyHeaderLoadingFinish() async {
    curRefreshState.value = RefreshState.header_load_finished;
    await Future.delayed(const Duration(milliseconds: 100));
    animToDefPos(isForceUpdate: true);
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

  void attach(MyRefreshState state) {
    myRefreshState = state;
  }

  void notifyRefreshFinish() {
    if (myRefreshState != null) {
      myRefreshState!.notifyHeaderLoadingFinish();
    }
  }
}
