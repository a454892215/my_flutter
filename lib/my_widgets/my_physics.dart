import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import '../util/Log.dart';

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

  /// 处理越界触摸滑动
  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    //  assert(offset != 0.0);
    //  assert(position.minScrollExtent <= position.maxScrollExtent);
    if (offset == 0.0 || position.minScrollExtent > position.maxScrollExtent) {
      Log.e("applyPhysicsToUserOffset 滚动数据异常");
    }
    double ret = offset;
    if (position.outOfRange) {
      final double overscrollPastStart = math.max(position.minScrollExtent - position.pixels, 0.0);
      final double overscrollPastEnd = math.max(position.pixels - position.maxScrollExtent, 0.0);
      final double overscrollPast = math.max(overscrollPastStart, overscrollPastEnd); /// 越界滚动距离
      /// 顺向反弹触摸滚动
      final bool easing = (overscrollPastStart > 0.0 && offset < 0.0) || (overscrollPastEnd > 0.0 && offset > 0.0);
      final double friction = easing
          // Apply less resistance when easing the overscroll vs tensioning.
          ? frictionFactor((overscrollPast - offset.abs()) / position.viewportDimension) /// 顺着反弹方向触摸滚动
          : frictionFactor(overscrollPast / position.viewportDimension); /// 顶住阻力触摸滚动
      final double direction = offset.sign;

      ret = direction * _applyFriction(overscrollPast, offset.abs(), friction);
    }
    /// 不处理惯性滑动下的越界，只处理触摸滑动下的越界！
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
      Log.d("createBallisticSimulation======velocity：$velocity=>${tolerance.velocity}  ${position.outOfRange}");
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

  // The ballistic simulation here decelerates more slowly than the one for
  // ClampingScrollPhysics so we require a more deliberate input gesture
  // to trigger a fling.
  @override
  double get minFlingVelocity => kMinFlingVelocity * 2.0;

  // Methodology:
  // 1- Use https://github.com/flutter/platform_tests/tree/master/scroll_overlay to test with
  //    Flutter and platform scroll views superimposed.
  // 3- If the scrollables stopped overlapping at any moment, adjust the desired
  //    output value of this function at that input speed.
  // 4- Feed new input/output set into a power curve fitter. Change function
  //    and repeat from 2.
  // 5- Repeat from 2 with medium and slow flings.
  /// Momentum build-up function that mimics iOS's scroll speed increase with repeated flings.
  ///
  /// The velocity of the last fling is not an important factor. Existing speed
  /// and (related) time since last fling are factors for the velocity transfer
  /// calculations.
  @override
  double carriedMomentum(double existingVelocity) {
    return existingVelocity.sign * math.min(0.000816 * math.pow(existingVelocity.abs(), 1.967).toDouble(), 40000.0);
  }

  // Eyeballed from observation to counter the effect of an unintended scroll
  // from the natural motion of lifting the finger after a scroll.
  @override
  double get dragStartDistanceMotionThreshold => 3.5;
}
