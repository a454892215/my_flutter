import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../interfaces/app_functions.dart';

typedef ItemBuilder = Widget Function(BuildContext context, int index, int selectedPos);

class ScrollRadioGroup extends StatelessWidget {
  ScrollRadioGroup({
    super.key,
    required this.size,
    required this.itemBuilder,
    this.scrollDir = Axis.horizontal,
    this.itemMargin = 10,
    this.bgColor,
    required this.width,
    required this.height,
    required this.itemWidth,
    required this.onSelectChanged,
  });

  final selectedIndex = 0.obs;
  final int size;
  final ItemBuilder itemBuilder;
  final Axis scrollDir;
  final double itemMargin;
  final double width;
  final double height;
  final double itemWidth;
  final Callback<int> onSelectChanged;
  final ScrollController scrollController = ScrollController();
  final Color? bgColor;
  final GlobalKey rootKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      assert(selectedIndex.value > -2);
      return Align(
        alignment: Alignment.topLeft,
        child: Container(
          key: rootKey,
          width: width,
          height: height,
          color: bgColor,
          child: ListView.separated(
            itemCount: size,
            shrinkWrap: true,
            scrollDirection: scrollDir,
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, pos) {
              return GestureDetector(
                onTap: () {
                  if (selectedIndex.value != pos) {
                    selectedIndex.value = pos;
                    onSelectChanged(pos);
                    autoScroll(pos);
                  }
                },
                child: itemBuilder(context, pos, selectedIndex.value),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: itemMargin, height: itemMargin);
            },
          ),
        ),
      );
    });
  }

  void autoScroll(int selectedPos) {
    final width = rootKey.currentContext?.size?.width ?? this.width;
    double selectedItemOriLeft = selectedPos * (itemMargin + itemWidth);
    var offset = scrollController.offset;
    double itemLeft = selectedItemOriLeft - offset;
    double itemCenter = width / 2 - itemLeft - itemWidth / 2;
    double realNeedScrollDistance = 0;
    if (itemCenter < 0) {
      double canToLeftMaxScroll = size * itemWidth + (size - 1) * itemMargin - width;
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
