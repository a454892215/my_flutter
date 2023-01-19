import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresh_state.dart';

Color fontColor = Colors.white;

Widget getHeaderWidget(RefreshState curRefreshState) {
  if (curRefreshState == RefreshState.pull_down_refresh) {
    return _buildPullDownRefreshWidget();
  } else if (curRefreshState == RefreshState.release_refresh) {
    return _buildReleaseRefreshWidget();
  } else if (curRefreshState == RefreshState.refreshing) {
    return _buildRefreshingWidget();
  } else if (curRefreshState == RefreshState.refresh_finished) {
    return _buildRefreshingFinishedWidget();
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
      Text('下拉刷新', style: TextStyle(fontSize: 15, color: fontColor)),
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
      Text('释放刷新', style: TextStyle(fontSize: 15, color: fontColor)),
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
      Text('正在刷新...', style: TextStyle(fontSize: 15, color: fontColor)),
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
      Text('刷新完成', style: TextStyle(fontSize: 15, color: fontColor)),
    ],
  );
}
