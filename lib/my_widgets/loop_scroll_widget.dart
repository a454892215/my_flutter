import 'package:flutter/material.dart';
import '../my_widgets/scrollable_pos_list/scrollable_positioned_list_my.dart';

typedef ItemBuilder = Widget Function(BuildContext context, int realItemIndex, int dataItemIndex);
// typedef OnSelectChanged = Widget Function(int realItemIndex, int dataItemIndex, dynamic param);

class LoopScrollWidget extends StatelessWidget {
  const LoopScrollWidget({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.isLoopScroll = true,
    this.itemScrollController,
    this.initialScrollIndex = 0,
    this.scrollAliment = 0.0,
    this.itemMargin = 0.0,
  });

  final int itemCount;
  final int initialScrollIndex;
  final bool isLoopScroll; // 循环滚动的最小item Count
  final ItemScrollController? itemScrollController;
  final double scrollAliment;
  final double itemMargin;
  final ItemBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    int originSize = itemCount;
    int loopScrollMaxSize = 100000 * originSize;
    int loopScrollMiddlePos = loopScrollMaxSize ~/ 2;
    return ScrollablePositionedList.separated(
      itemCount: isLoopScroll ? loopScrollMaxSize : originSize,
      itemScrollController: itemScrollController,
      shrinkWrap: true,
      initialScrollIndex: isLoopScroll ? loopScrollMiddlePos : 0,
      initialAlignment: isLoopScroll ? scrollAliment : 0,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int itemRealIndex) {
        int itemDataIndex = itemRealIndex % originSize;
        return itemBuilder(context, itemRealIndex, itemDataIndex);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: itemMargin);
      },
      //
    );
  }
}
