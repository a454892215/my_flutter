import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../interfaces/app_functions.dart';

typedef ItemBuilder = Widget Function(BuildContext context, int index, int selectedPos);

class IndicatorTabGroup extends StatelessWidget {
  IndicatorTabGroup({
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

  final selectedIndex = 0.obs;
  final int size;
  final ItemBuilder itemBuilder;
  final double itemMargin;
  final double width;
  final double height;
  final double itemWidth;
  final Callback<int> onSelectChanged;
  final ScrollController scrollController = ScrollController();
  final Color? bgColor;
  final Alignment alignment;
  final GlobalKey rootKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      assert(selectedIndex.value > -2);
      return Align(
        alignment: alignment,
        child: Container(
          key: rootKey,
          width: width,
          height: height,
          color: bgColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(size, (pos) {
                return GestureDetector(
                  onTap: () => onItemSelectChanged(pos),
                  child: itemBuilder(context, pos, selectedIndex.value),
                );
              }),
            ),
          ),
        ),
      );
    });
  }

  void onItemSelectChanged(int pos) {
    if (selectedIndex.value != pos) {
      selectedIndex.value = pos;
      onSelectChanged(pos);
      autoScroll(pos);
    }
  }

  void autoScroll(int selectedPos) {
    double parentWidth = rootKey.currentContext?.size?.width ?? this.width;
    double contentWidth = size * itemWidth + (size - 1) * itemMargin;
    double width = contentWidth < parentWidth ? contentWidth : parentWidth;
    double selectedItemOriLeft = selectedPos * (itemMargin + itemWidth);
    var offset = scrollController.offset;
    double itemLeft = selectedItemOriLeft - offset;
    double itemCenter = width / 2 - itemLeft - itemWidth / 2;
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
