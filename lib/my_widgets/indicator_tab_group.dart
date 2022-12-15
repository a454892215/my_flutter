import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../interfaces/app_functions.dart';
import 'comm_anim2.dart';

typedef ItemBuilder = Widget Function(BuildContext context, int index, int selectedPos);

class IndicatorTabGroup extends StatefulWidget {
  const IndicatorTabGroup({
    super.key,
    required this.size,
    required this.itemBuilder,
    this.itemMargin = 0,
    this.bgColor,
    this.alignment = Alignment.topLeft,
    required this.width,
    required this.height,
    required this.itemWidth,
    required this.onSelectChanged,
  });

  final int size;
  final ItemBuilder itemBuilder;
  final double itemMargin;
  final double width;
  final double height;
  final double itemWidth;
  final Callback<int> onSelectChanged;
  final Color? bgColor;
  final Alignment alignment;

  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State<IndicatorTabGroup> with TickerProviderStateMixin {
  final GlobalKey rootKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  final selectedIndex = 0.obs;
  final indicatorLeft = 0.0.obs;
  late CommonTweenAnim<double> anim = CommonTweenAnim<double>()
    ..init(200, this, 0.0, 0.0)
    ..addListener(onUpdate);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      assert(selectedIndex.value > -2);
      return Align(
        alignment: widget.alignment,
        child: Container(
          key: rootKey,
          width: widget.width,
          height: widget.height,
          color: widget.bgColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Row(
                  children: List.generate(widget.size, (pos) {
                    return GestureDetector(
                      onTap: () => onItemSelectChanged(pos),
                      child: widget.itemBuilder(context, pos, selectedIndex.value),
                    );
                  }),
                ),
                Obx(
                  () => Positioned(
                    left: indicatorLeft.value,
                    //   rect: anim.animation,
                    child: Container(
                      width: widget.itemWidth,
                      height: 3,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  void onItemSelectChanged(int pos) {
    if (selectedIndex.value != pos) {
      anim.updateEndAndStart(pos * widget.itemWidth);
      selectedIndex.value = pos;
      widget.onSelectChanged(pos);
      autoScroll(pos);
    }
  }

  void onUpdate() {
    if(anim.animation != null){
      indicatorLeft.value = anim.animation!.value;
    }
  }

  void autoScroll(int selectedPos) {
    double parentWidth = rootKey.currentContext?.size?.width ?? widget.width;
    double contentWidth = widget.size * widget.itemWidth + (widget.size - 1) * widget.itemMargin;
    double width = contentWidth < parentWidth ? contentWidth : parentWidth;
    double selectedItemOriLeft = selectedPos * (widget.itemMargin + widget.itemWidth);
    var offset = scrollController.offset;
    double itemLeft = selectedItemOriLeft - offset;
    double itemCenter = width / 2 - itemLeft - widget.itemWidth / 2;
    double realNeedScrollDistance = 0;
    if (itemCenter < 0) {
      double canToLeftMaxScroll = contentWidth - width;
      double canToLeftScroll = canToLeftMaxScroll - offset;
      realNeedScrollDistance = canToLeftScroll < itemCenter.abs() ? -canToLeftScroll : itemCenter;
    } else {
      // 向右边滚动
      double canToRightScroll = offset;
      realNeedScrollDistance = canToRightScroll < itemCenter.abs() ? canToRightScroll : itemCenter;
    }
    scrollController.animateTo(offset - realNeedScrollDistance, duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }
}
