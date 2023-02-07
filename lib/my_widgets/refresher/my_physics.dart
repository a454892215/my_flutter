import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import '../../util/Log.dart';

const double kMinFlingVelocity = 50.0;

class MyBouncingScrollPhysics extends ScrollPhysics {
  const MyBouncingScrollPhysics() : super(parent: null);

  /// 回返自身对象
  @override
  MyBouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    // super.applyTo(ancestor);
    return const MyBouncingScrollPhysics();
  }

  /// 随距离增大，返回值逐渐变小（手指触摸UI并且已经越界才调用）
  double frictionFactor(double overscrollFraction) {
    double v = 0.52 * math.pow(1 - overscrollFraction, 2);
    // EasyThrottle.throttle('frictionFactor', const Duration(milliseconds: 0), () {
    //   Log.d("overscrollFraction: $overscrollFraction  v:$v");
    // });
    return v;
  }

  /// 处理触摸滑动
  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    //  assert(offset != 0.0);
    //  assert(position.minScrollExtent <= position.maxScrollExtent);
    if (offset == 0.0 || position.minScrollExtent > position.maxScrollExtent) {
      Log.e(" 滚动数据异常");
    }
    double ret = offset;
    if (position.outOfRange) {
      final double overscrollPastStart = math.max(position.minScrollExtent - position.pixels, 0.0);
      final double overscrollPastEnd = math.max(position.pixels - position.maxScrollExtent, 0.0);
      final double overscrollPast = math.max(overscrollPastStart, overscrollPastEnd);

      /// 越界滚动距离
      /// 顺向反弹触摸滚动
      final bool easing = (overscrollPastStart > 0.0 && offset < 0.0) || (overscrollPastEnd > 0.0 && offset > 0.0);
      final double friction = easing
          // Apply less resistance when easing the overscroll vs tensioning.
          ? frictionFactor((overscrollPast - offset.abs()) / position.viewportDimension)

          /// 顺着反弹方向触摸滚动
          : frictionFactor(overscrollPast / position.viewportDimension);

      /// 顶住阻力触摸滚动
      final double direction = offset.sign;

      ret = direction * _applyFriction(overscrollPast, offset.abs(), friction);
    }

    /// 不处理惯性滑动下滚动
    // Log.d("ret:$ret  isOut:${position.outOfRange}");
    return ret;
  }

  static double _applyFriction(double extentOutside, double absDelta, double gamma) {
    // assert(absDelta > 0);

    double total = 0.0;
    if (extentOutside > 0) {
      final double deltaToLimit = extentOutside / gamma;
      if (absDelta < deltaToLimit) {
        return absDelta * gamma;
      }
      total += extentOutside;
      absDelta -= deltaToLimit;
    }
    return total + absDelta;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) => 0.0;

  /// 处理惯性滚动
  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final Tolerance tolerance = this.tolerance;
    if (velocity.abs() >= tolerance.velocity || position.outOfRange) {
      Log.d(" spring：$spring  position:${position.pixels}  velocity:$velocity  "
          "leadingExtent:${position.minScrollExtent} trailingExtent:${position.maxScrollExtent}  tolerance:$tolerance");
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity,
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  double get minFlingVelocity => kMinFlingVelocity * 2.0;

  @override
  double carriedMomentum(double existingVelocity) {
    return existingVelocity.sign * math.min(0.000816 * math.pow(existingVelocity.abs(), 1.967).toDouble(), 40000.0);
  }

  // Eyeballed from observation to counter the effect of an unintended scroll
  // from the natural motion of lifting the finger after a scroll.
  @override
  double get dragStartDistanceMotionThreshold => 3.5;
}

//ignore: must_be_immutable
class RefresherClampingScrollPhysics extends ClampingScrollPhysics {
  RefresherClampingScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);
  bool scrollEnable = true;

  @override
  RefresherClampingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return RefresherClampingScrollPhysics(parent: buildParent(ancestor));
  }

  /// 处理触摸滑动
  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (offset == 0.0 || position.minScrollExtent > position.maxScrollExtent) {
      Log.e(" 滚动数据异常");
    }
    if (position.outOfRange) {}
    if (scrollEnable) {
      return offset;
    }
    return 0;
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if(!scrollEnable){
      return null;
    }
    return super.createBallisticSimulation(position, velocity);
  }
}
