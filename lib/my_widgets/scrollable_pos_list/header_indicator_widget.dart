import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'refresh_state.dart';


Color fontColor = const Color(0xff9a9a9a);

class HeaderWidgetBuilder {
  Widget getHeaderWidget(RefreshState curRefreshState, RefresherFunc func) {
    if(func == RefresherFunc.bouncing || func == RefresherFunc.no_func){
      return const SizedBox();
    }
    if (curRefreshState == RefreshState.def) {
      return _buildPullDownRefreshWidget();
    } else if (curRefreshState == RefreshState.header_release_load) {
      return _buildReleaseRefreshWidget();
    } else if (curRefreshState == RefreshState.header_loading) {
      return _buildRefreshingWidget();
    } else if (curRefreshState == RefreshState.header_load_finished) {
      return _buildRefreshingFinishedWidget();
    } else if (curRefreshState == RefreshState.all_data_load_finished) {
      return _buildAllDataLoadFinishedWidget();
    } else if (curRefreshState == RefreshState.header_locked_by_footer) {
      return _buildLockedWidget();
    }
    return const SizedBox();
  }

  Widget _buildPullDownRefreshWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.arrow_downward, color: fontColor, size: 20),
        const SizedBox(width: 6),
        Text('下拉加载.', style: TextStyle(fontSize: 15, color: fontColor)),
      ],
    );
  }

  Widget _buildReleaseRefreshWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.arrow_upward, color: fontColor, size: 20),
        const SizedBox(width: 6),
        Text('释放加载.', style: TextStyle(fontSize: 15, color: fontColor)),
      ],
    );
  }

  Widget _buildRefreshingWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoActivityIndicator(color: fontColor),
        const SizedBox(width: 6),
        Text('正在加载...', style: TextStyle(fontSize: 15, color: fontColor)),
      ],
    );
  }

  Widget _buildRefreshingFinishedWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.done, color: fontColor, size: 20),
        const SizedBox(width: 6),
        Text('加载完成.', style: TextStyle(fontSize: 15, color: fontColor)),
      ],
    );
  }

  Widget _buildLockedWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.done, color: fontColor, size: 20),
        const SizedBox(width: 6),
        Text('脚部正在加载中.', style: TextStyle(fontSize: 15, color: fontColor)),
      ],
    );
  }

  Widget _buildAllDataLoadFinishedWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.done, color: fontColor, size: 20),
        const SizedBox(width: 6),
        Text('所有数据已加载完毕.', style: TextStyle(fontSize: 15, color: fontColor)),
      ],
    );
  }
}
