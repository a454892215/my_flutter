import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/refresher/refresh_state.dart';

Color fontColor = const Color(0xff9a9a9a);

class FooterWidgetBuilder {
  Widget getFooterWidget(RefreshState curRefreshState, RefresherFunc func) {
    if(func == RefresherFunc.bouncing || func == RefresherFunc.no_func){
      return const SizedBox();
    }
    if (curRefreshState == RefreshState.footer_pull_up_load) {
      return _buildPullUpLoadWidget();
    } else if (curRefreshState == RefreshState.footer_release_load) {
      return _buildReleaseLoadWidget();
    } else if (curRefreshState == RefreshState.footer_loading) {
      return _buildLoadingWidget();
    } else if (curRefreshState == RefreshState.footer_load_finished) {
      return _buildLoadingFinishedWidget();
    }
    return const SizedBox();
  }

  Widget _buildPullUpLoadWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.arrow_downward, color: fontColor, size: 20),
        const SizedBox(width: 6),
        Text('上拉加载.', style: TextStyle(fontSize: 15, color: fontColor)),
      ],
    );
  }

  Widget _buildReleaseLoadWidget() {
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

  Widget _buildLoadingWidget() {
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

  Widget _buildLoadingFinishedWidget() {
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
}
