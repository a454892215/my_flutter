import 'package:my_flutter_lib_3/my_widgets/refresher/refresh_state.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresher.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresher_param.dart';

class StateManager {
  RefreshState curRefreshState = RefreshState.header_pull_down_load;
  final Refresher widget;
  final RefresherParam param;
  final RefreshWidgetState state;

  StateManager(this.widget, this.param, this.state);

  Future<void> updateHeaderState(int switchType) async {
    if (switchType == 1) {
      if (curRefreshState == RefreshState.header_pull_down_load) {
        curRefreshState = RefreshState.header_release_load;
      } else {
        curRefreshState = RefreshState.header_pull_down_load;
      }
    } else if (switchType == 2) {
      // 释放加载 => 正在加载 或下拉加载状态不变，动画隐藏头
      if (curRefreshState == RefreshState.header_release_load) {
        curRefreshState = RefreshState.header_loading;
      }
    } else if (switchType == 3) {
      // 正在加载->加载结束
      if (curRefreshState == RefreshState.header_loading) {
        curRefreshState = RefreshState.header_load_finished;
      }
    } else if (switchType == 4) {
      // 加载结束 -> 下拉加载
      if (curRefreshState == RefreshState.header_load_finished) {
        curRefreshState = RefreshState.header_pull_down_load;
      }
    } else if (switchType == 5) {
      // 下拉加载 -> 释放加载
      if (curRefreshState == RefreshState.header_pull_down_load) {
        curRefreshState = RefreshState.header_release_load;
      } else if (curRefreshState == RefreshState.header_release_load) {
        curRefreshState = RefreshState.header_loading;
      }
    }
    if (curRefreshState == RefreshState.header_pull_down_load) {
      param.refreshFinishOffset = 0;
    } else if (curRefreshState == RefreshState.header_loading) {
      if (widget.onHeaderLoad != null) {
        widget.onHeaderLoad!(state);
      }
    }
    // Log.d("curRefreshState: ${curRefreshState.name} : ${curRefreshState.index}  switchType:$switchType ");
  }
}
