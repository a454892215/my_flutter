import 'package:my_flutter_lib_3/my_widgets/refresher/refresh_state.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresher.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresher_param.dart';

class StateManager {
  RefreshState curHeaderRefreshState = RefreshState.header_pull_down_load;
  RefreshState curFooterRefreshState = RefreshState.footer_pull_up_load;
  final Refresher widget;
  final RefresherParam param;
  final RefreshWidgetState state;

  StateManager(this.widget, this.param, this.state);

  Future<void> updateHeaderState(int switchType) async {
    if (switchType == 1) {
      if (curHeaderRefreshState == RefreshState.header_pull_down_load) {
        curHeaderRefreshState = RefreshState.header_release_load;
      } else {
        curHeaderRefreshState = RefreshState.header_pull_down_load;
      }
    } else if (switchType == 2) {
      // 释放加载 => 正在加载 或下拉加载状态不变，动画隐藏头
      if (curHeaderRefreshState == RefreshState.header_release_load) {
        curHeaderRefreshState = RefreshState.header_loading;
      }
    } else if (switchType == 3) {
      // 正在加载->加载结束
      if (curHeaderRefreshState == RefreshState.header_loading) {
        curHeaderRefreshState = RefreshState.header_load_finished;
      }
    } else if (switchType == 4) {
      // 加载结束 -> 下拉加载
      if (curHeaderRefreshState == RefreshState.header_load_finished) {
        curHeaderRefreshState = RefreshState.header_pull_down_load;
      }
    } else if (switchType == 5) {
      // 下拉加载 -> 释放加载
      if (curHeaderRefreshState == RefreshState.header_pull_down_load) {
        curHeaderRefreshState = RefreshState.header_release_load;
      } else if (curHeaderRefreshState == RefreshState.header_release_load) {
        curHeaderRefreshState = RefreshState.header_loading;
      }
    }
    if (curHeaderRefreshState == RefreshState.header_pull_down_load) {
      param.loadFinishOffset = 0;
    } else if (curHeaderRefreshState == RefreshState.header_loading) {
      if (widget.onHeaderLoad != null) {
        widget.onHeaderLoad!(state);
      }
    }
    // Log.d("curRefreshState: ${curRefreshState.name} : ${curRefreshState.index}  switchType:$switchType ");
  }

  RefreshState getTarHeaderState() {
    RefreshState tarState = curHeaderRefreshState;
    if (curHeaderRefreshState == RefreshState.header_release_load && !state.isPressed) {
      tarState = RefreshState.header_loading;
    } else if (!state.headerHandler.isLoadingOrFinishedState()) {
      if (state.headerHandler.getScrolledHeaderY() >= param.headerTriggerRefreshDistance) {
        tarState = RefreshState.header_release_load;
      } else {
        tarState = RefreshState.header_pull_down_load;
      }
    }
    return tarState;
  }

  RefreshState _computeNextFooterStateByCurState(int condition) {
    RefreshState tarState = curFooterRefreshState;
    var footerHandler = state.footerHandler;
    if (condition == 1) {
      // 触摸显示出footer
      if (footerHandler.getScrolledFooterDistance() > param.footerIndicatorHeight) {
        tarState = RefreshState.footer_release_load;
      } else {
        tarState = RefreshState.footer_pull_up_load;
      }
      curFooterRefreshState = tarState;
      // 手指释放
    } else if (condition == 2) {
      if (footerHandler.getScrolledFooterDistance() > param.footerIndicatorHeight) {
        tarState = RefreshState.footer_loading; // fling条件下可以从footer_pull_up_load直接进入footer_loading
      } else {
        tarState = RefreshState.footer_pull_up_load;
      }
    } else if (condition == 3) {
      tarState = RefreshState.footer_load_finished;
    } else if (condition == 4) {
      tarState = RefreshState.footer_pull_up_load;
    }
    return tarState;
  }

  void updateFooterState(int condition) {
    var tarState = _computeNextFooterStateByCurState(condition);
    if (curFooterRefreshState == tarState) return;
    curFooterRefreshState = tarState;
    if (curFooterRefreshState == RefreshState.footer_loading) {
      if (widget.onFooterLoad != null) {
        widget.onFooterLoad!(state);
      }
    }else if(curFooterRefreshState == RefreshState.footer_pull_up_load){
      param.loadFinishOffset = 0;
    }
  }
}
