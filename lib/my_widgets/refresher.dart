import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/Log.dart';

void main() {}

class Refresher extends StatefulWidget {
  const Refresher({super.key, required this.child, required this.sc});

  final Widget child;
  final ScrollController sc;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<Refresher> {
  @override
  void initState() {
    super.initState();
    ScrollController sc = widget.sc;
    widget.sc.addListener(() {
      // Log.d("sc: ${sc.offset}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails detail) {
            var delta = detail.delta;
            Log.d("delta: $delta");
          },
          child: widget.child,
        ),
      ],
    );
  }
}
