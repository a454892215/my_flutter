import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

typedef WidgetBuilder = Widget Function(BuildContext context, int index);
typedef OnCollapse = void Function(bool isOpen);

class Collapse extends StatefulWidget {
   Collapse({
    super.key,
    required this.title,
    required this.childSize,
    required this.widgetBuilder,
    this.isOpen = false,
    this.onCollapse,
    required this.collapseController,
  }){
     collapseController.attach(this);
  }

  final Widget title;
  final int childSize;
  final WidgetBuilder widgetBuilder;
  final OnCollapse? onCollapse;
  final bool isOpen;
  final CollapseController collapseController;
   final collapseTurns = 0.0.obs;

  @override
  State<StatefulWidget> createState() {
    return CollapseState();
  }
}

class CollapseState extends State<Collapse> with SingleTickerProviderStateMixin {
  late bool isOpen = widget.isOpen;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          minSize: 0,
          padding: EdgeInsets.zero,
          onPressed: () {
            isOpen = !isOpen;
            widget.collapseTurns.value = isOpen ? 0.25 : 0;
            if (widget.onCollapse != null) {
              widget.onCollapse!(isOpen);
            }
            if (isOpen) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          },
          child: widget.title,
        ),
        SizeTransition(
          sizeFactor: _animation,
          child: Column(
            children: List.generate(widget.childSize, (index) => widget.widgetBuilder(context, index)),
          ),
        ),
      ],
    );
  }
}

class CollapseArrow extends StatelessWidget {
  final CollapseController collapseController;

  const CollapseArrow({super.key, required this.collapseController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var value = collapseController.collapse!.collapseTurns.value;
        return AnimatedRotation(
          turns: value,
          duration: const Duration(milliseconds: 250),
          child: Image.asset("assets/images/collapse_arrow.webp", width: 20.w),
        );
      },
    );
  }
}

class CollapseController {
  Collapse? collapse;

  void attach(Collapse collapse) {
    this.collapse = collapse;
  }
}
