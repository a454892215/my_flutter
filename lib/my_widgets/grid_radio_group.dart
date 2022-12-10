import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../interfaces/app_functions.dart';

typedef ItemBuilder = Widget Function(BuildContext context, int index, int selectedPos);

class GridRadioGroup extends StatefulWidget {
  const GridRadioGroup({
    super.key,
    required this.size,
    required this.itemBuilder,
    this.scrollDir = Axis.vertical,
    this.itemMargin = 10,
    this.isCanCancelSelect = true,
    required this.controller,
    required this.width,
    required this.height,
    required this.onSelectChanged,
    required this.crossAxisCount,
  });

  final int size;
  final ItemBuilder itemBuilder;
  final Axis scrollDir;
  final double itemMargin;
  final double? width;
  final double? height;
  final Callback2<int, bool> onSelectChanged;
  final SliverGridDelegateWithFixedCrossAxisCount crossAxisCount;
  final bool isCanCancelSelect;
  final GridRadioGroupController controller;

  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State<GridRadioGroup> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      GridRadioGroupController controller = widget.controller;
      assert(controller.selectedIndex.value > -2);
      return SizedBox(
        width: widget.width,
        height: widget.size == 0 ? 0: widget.height,
        child: GridView.builder(
          itemCount: widget.size,
          shrinkWrap: true,
          scrollDirection: widget.scrollDir,
          padding: const EdgeInsets.all(0),

          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, pos) {
            return GestureDetector(
              onTap: () {
                if (widget.isCanCancelSelect && controller.selectedIndex.value == pos) {
                  widget.onSelectChanged(pos, false);
                  controller.selectedIndex.value = -1;
                } else if (controller.selectedIndex.value != pos) {
                  widget.onSelectChanged(pos, true);
                  controller.selectedIndex.value = pos;
                }
              },
              child: widget.itemBuilder(context, pos, controller.selectedIndex.value),
            );
          },
          gridDelegate: widget.crossAxisCount,
        ),
      );
    });
  }
}

class GridRadioGroupController {
  GridRadioGroupController({int defSelectedPos = -1}) {
    selectedIndex.value = defSelectedPos;
  }

  final selectedIndex = 0.obs;

  void setSelectedPos(int pos) {
    selectedIndex.value = pos;
  }

  void clearSelect(){
    selectedIndex.value = -1;
  }
}
