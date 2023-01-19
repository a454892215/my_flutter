import 'package:flutter/material.dart';

import '../util/Log.dart';
import 'comm_anim2.dart';

void main() {}

class Refresher extends StatefulWidget {
  const Refresher({
    super.key,
    required this.child,
    required this.sc,
    required this.height,
    required this.width,
  });

  final Widget child;
  final ScrollController sc;
  final double height;
  final double width;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<Refresher> with TickerProviderStateMixin {
  late ScrollController sc = widget.sc;

  late double curAnimValue = 0;
  late final ValueNotifier<double> notifier = ValueNotifier<double>(curAnimValue);

  late CommonTweenAnim<double> anim = CommonTweenAnim<double>()
    ..init(200, this, 0, 1)
    ..addListener(onAnimUpdate);
  int state = 0;
  double headerHeight = 120;

  void onAnimUpdate() {
    curAnimValue = anim.animation?.value ?? 0;
    notifier.value = curAnimValue;
    if (anim.controller.isCompleted && state != 1) {
      state = 1;
    } else if (anim.controller.isDismissed && state != -1) {
      state = -1;
    } else {
      state = 0;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (a, b, c) {
        print("===ValueListenableBuilder=${notifier.value}===");
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: OverflowBox(alignment: Alignment.topLeft, maxHeight: widget.height * 3, child: _buildContent()),
        );
      },
    );
  }

  Column _buildContent() {
    return Column(
      //  mainAxisSize: MainAxisSize.min,
      children: [
        _buildColumn(),
        Transform.translate(
          offset: Offset(0, -headerHeight),
          child: Listener(
            onPointerMove: onPointerMove,
            child: widget.child,
          ),
        ),
      ],
    );
  }

  Widget _buildColumn() {
    return Column(
      children: [
        Container(
          color: Colors.yellow,
          height: 40,
          width: widget.width,
        ),
        Container(
          color: Colors.red,
          height: 40,
          width: widget.width,
        ),
        Container(
          color: Colors.blue,
          height: 40,
          width: widget.width,
        ),
      ],
    );
  }

  void onPointerMove(PointerMoveEvent e) {
    ScrollPosition position = sc.position;
    var max = position.maxScrollExtent;
    var min = position.minScrollExtent;
    var pixels = position.pixels;
    if (pixels >= max || pixels <= min) {
      Log.d("越界滑动状态 onTap:  ${e.delta}  max:$max   min:$min   pixels:$pixels");
    }
  }
}
