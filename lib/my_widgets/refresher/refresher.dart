import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresh_state.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresher_param.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/state_manager.dart';
import '../../util/Log.dart';
import 'footer_handler.dart';
import 'footer_indicator_widget.dart';
import 'header_handler.dart';
import 'my_physics.dart';
import 'header_indicator_widget.dart';

void main() {}

typedef OnHeaderStartLoad = void Function(RefreshWidgetState state);
typedef OnFooterStartLoad = void Function(RefreshWidgetState state);

class Refresher extends StatefulWidget {
  const Refresher({
    super.key,
    required this.child,
    required this.sc,
    required this.height,
    required this.width,
    this.headerFnc = RefresherFunc.load_more,
    this.footerFnc = RefresherFunc.bouncing,
    this.isReverseScroll = true,
    this.onHeaderLoad,
    this.onFooterLoad,
    required this.controller,
  });

  final Widget child;
  final ScrollController sc;
  final double height;
  final double width;
  final OnHeaderStartLoad? onHeaderLoad;
  final OnFooterStartLoad? onFooterLoad;
  final RefresherFunc headerFnc;
  final RefresherFunc footerFnc;
  final RefresherController controller;
  final bool isReverseScroll;

  @override
  State<StatefulWidget> createState() {
    return RefreshWidgetState();
  }
}

class RefreshWidgetState extends State<Refresher> with TickerProviderStateMixin {
  late ScrollController sc = widget.sc;
  RefresherParam param = RefresherParam();

  late final ValueNotifier<double> notifier = ValueNotifier<double>(-param.headerHeight);

  late StateManager stateManager = StateManager(widget, param, this);
  late HeaderHandler headerHandler = HeaderHandler(notifier, this);
  late FooterHandler footerHandler = FooterHandler(notifier, this);

  @override
  void initState() {
    super.initState();
    double lastOffset = 0;
    sc.addListener(() {
      double dY = sc.offset - lastOffset;
      if (widget.isReverseScroll) dY = -dY;
      if (isScrollToTop() && !isPressed) {
        // 头尾不可见
        headerHandler.onStartFling(-dY);
      } else if (isScrollToBot() && !isPressed) {
        footerHandler.onStartFling(dY);
      }
      lastOffset = sc.offset;
    });
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
          Builder(builder: (_) {
            ///    Log.d("refreshFinishOffset: ${param.refreshFinishOffset}");
            return const SizedBox();
          }),
          Positioned(
              left: 0,
              top: param.headerHeight,
              child: Transform.translate(
                offset: Offset(0, param.loadFinishOffset != 0 ? param.loadFinishOffset : notifier.value),
                child: Listener(
                  onPointerMove: onPointerMove,
                  onPointerUp: onPointerUp,
                  onPointerDown: (e) {
                    if (headerHandler.animFling.controller.isAnimating) {
                      headerHandler.animFling.controller.stop();
                    }
                    isPressed = true;
                  },
                  child: widget.child,
                ),
              )),
          Transform.translate(
            offset: Offset(0, notifier.value),
            child: _buildHeader(),
          ),
          Positioned(
            left: 0,
            top: param.headerHeight + widget.height,
            child: Transform.translate(
              offset: Offset(0, notifier.value),
              child: _buildFooter(),
            ),
          )
        ],
      ),
    );
  }

  HeaderWidgetBuilder headerWidgetBuilder = HeaderWidgetBuilder();
  FooterWidgetBuilder footerWidgetBuilder = FooterWidgetBuilder();

  Widget _buildHeader() {
    return SizedBox(
      height: param.headerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: param.headerIndicatorHeight,
            width: widget.width,
            alignment: Alignment.center,
            child: headerWidgetBuilder.getHeaderWidget(stateManager.curHeaderRefreshState, widget.headerFnc),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return SizedBox(
      height: param.footerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: param.footerIndicatorHeight,
            width: widget.width,
            alignment: Alignment.center,
            child: footerWidgetBuilder.getFooterWidget(stateManager.curFooterRefreshState, widget.headerFnc),
          ),
        ],
      ),
    );
  }

  Future<void> onPointerUp(PointerUpEvent event) async {
    isPressed = false;
    if (headerHandler.isLoadingOrFinishedState() || footerHandler.isLoadingOrFinishedState()) {
      Log.d("LoadingOrFinished...");
      return;
    }
    if (headerHandler.isShowing()) {
      headerHandler.onStartFling(footerHandler.lastRealTouchMoveDy * 8);
    } else if (footerHandler.isShowing()) {
      footerHandler.onStartFling(-footerHandler.lastRealTouchMoveDy * 8);
    }
  }

  void onPointerMove(PointerMoveEvent e) {
    if (sc.position.physics is RefresherClampingScrollPhysics) {
      RefresherClampingScrollPhysics physics = sc.position.physics as RefresherClampingScrollPhysics;
      physics.scrollEnable = headerHandler.isHidden() || footerHandler.isHidden();
      if (headerHandler.isShowing() || footerHandler.isShowing()) {
        physics.scrollEnable = false;
      }
      if (footerHandler.isHidden() && e.delta.dy > 0 && !isScrollToTop()) {
        physics.scrollEnable = true;
      }
      if (headerHandler.isLoadingOrFinishedState() || footerHandler.isLoadingOrFinishedState()) {
        physics.scrollEnable = false;
      }
    } else {
      throw Exception("滚动 Widget 的 physics 必须是 RefresherClampingScrollPhysics ");
    }
    eventDispatch(e);
  }

  void eventDispatch(PointerMoveEvent e) {
    if (headerHandler.isLoadingOrFinishedState() || footerHandler.isLoadingOrFinishedState()) {
      return;
    }
    if (headerHandler.isShowing()) {
      handleHeaderTouchScroll(e);
    } else if (footerHandler.isShowing()) {
      handleFooterTouchScroll(e);
    } else if (e.delta.dy > 0) {
      handleHeaderTouchScroll(e);
    } else if (e.delta.dy < 0) {
      handleFooterTouchScroll(e);
    }
  }

  void handleFooterTouchScroll(PointerMoveEvent e) {
    if (isScrollToBot()) {
      if (widget.footerFnc == RefresherFunc.no_func) {
        return;
      }
      footerHandler.handleFooterTouchScroll(e);
      // Log.d("======= dy:${e.delta.dy}");
    }
  }

  void handleHeaderTouchScroll(PointerMoveEvent e) {
    if (isScrollToTop()) {
      if (widget.headerFnc == RefresherFunc.no_func) {
        return;
      }
      if (headerHandler.isLoadingOrFinishedState()) {
        return;
      }
      headerHandler.handleHeaderTouchScroll(e);
    }
  }

  bool isScrollToTop() {
    if (widget.isReverseScroll) {
      return sc.position.extentAfter == 0;
    } else {
      return sc.position.extentBefore == 0;
    }
  }

  bool isScrollToBot() {
    if (widget.isReverseScroll) {
      return sc.position.extentBefore == 0;
    } else {
      return sc.position.extentAfter == 0;
    }
  }

  void notifyHeaderLoadFinish({isNeedOffset = true}) {
    widget.controller.isNeedHeaderOffsetOnLoadFinished = isNeedOffset;
    //  正在加载->加载结束
    stateManager.updateHeaderState(3);
    headerHandler.onHeaderLoadFinished();
  }

  void notifyFooterLoadFinish({isNeedOffset = true}) {
    //  正在加载->加载结束
    widget.controller.isNeedFooterOffsetOnLoadFinished = isNeedOffset;
    stateManager.updateFooterState(3);
    footerHandler.onFooterLoadFinished();
  }
}

class RefresherController {
  /// 如果加载跟多没有加载到更多的内容，或者加载的内容不足做偏移， 则可不做偏移
  bool isNeedHeaderOffsetOnLoadFinished = true;
  bool isNeedFooterOffsetOnLoadFinished = true;
}
