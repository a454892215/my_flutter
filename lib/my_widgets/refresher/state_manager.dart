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
      param.refreshFinishOffset = 0;
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

  RefreshState computeNextFooterStateByCurState(int condition) {
    RefreshState tarState = curHeaderRefreshState;
    if (condition == 1) {
      curFooterRefreshState = tarState;
    }
    return tarState;
  }

  void updateFooterState(int condition, RefreshState tarState) async {
    if (curFooterRefreshState == tarState) return;
    if (condition == 1) {
      curFooterRefreshState = tarState;
    }
  }
}
