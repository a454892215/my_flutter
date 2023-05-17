import 'package:flutter/cupertino.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.child,
    required this.bgColor,
    required this.radius,
    required this.height,
    required this.horPadding,
  });

  final Text child;
  final Color bgColor;
  final double radius;
  final double height;
  final double horPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: horPadding),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
