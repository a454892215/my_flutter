
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef Callback = void Function(int dir);

class BouncingExpand {
  final Callback callback;

  BouncingExpand(this.callback);

  /// 手指释放瞬间的越界大小
  double releaseBounceDistance = 0;

  /// 最小触发距离
  double minTriggerDistance = 40.w;

  /// 是否释放瞬间
  bool isReleaseState1 = false;

  void onPointerDown() {
    isReleaseState1 = false;
    releaseBounceDistance = 0;
  }

  void onPointerUp() {
    isReleaseState1 = true;
  }

  void onBouncing(ScrollMetrics metrics) {
    var pixels = metrics.pixels;
    var maxScroll = metrics.maxScrollExtent;
    if (isReleaseState1 && releaseBounceDistance == 0) {
      releaseBounceDistance = pixels > 0 ? pixels - maxScroll : -pixels;
    }

    /// 当前越界距离
    if (isReleaseState1 && releaseBounceDistance >= minTriggerDistance) {
      int dir = pixels < 0 ? -1 : 1;
      callback(dir);

      /// 重置
      releaseBounceDistance = 0;
      isReleaseState1 = false;
    }
  }
}
