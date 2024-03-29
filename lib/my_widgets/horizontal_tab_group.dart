import 'package:flutter/material.dart';
import 'comm_anim2.dart';

typedef ItemBuilder = Widget Function(BuildContext context, int index, int selectedPos);
typedef Callback<T> = void Function(T t);

class HorizontalTabGroup extends StatefulWidget {
  const HorizontalTabGroup({
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
    this.indicatorAttr,
    required this.controller,
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
  final IndicatorAttr? indicatorAttr;
  final IndicatorTabController controller;

  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State<HorizontalTabGroup> with TickerProviderStateMixin {
  final GlobalKey rootKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  late CommonTweenAnim<double> anim = CommonTweenAnim<double>()
    ..init(200, this, 0.0, 0.0)
    ..addListener(onUpdate);
  final ValueNotifier<double> leftNotifier = ValueNotifier<double>(0.0);

  @override
  Widget build(BuildContext context) {
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
              ValueListenableBuilder(
                valueListenable: widget.controller.selectedIndexNotifier,
                builder: (BuildContext context, int value, Widget? child) {
                  return Row(
                    children: List.generate(widget.size, (pos) {
                      return GestureDetector(
                        onTap: () => onItemSelectChanged(pos),
                        child: _buildItem(context, pos),
                      );
                    }),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: leftNotifier,
                builder: (BuildContext context, double value, Widget? child) {
                  return Positioned(
                    left: value,
                    child: Container(
                      width: widget.itemWidth,
                      height: widget.indicatorAttr?.height,
                      padding: EdgeInsets.only(left: widget.indicatorAttr?.horPadding ?? 0, right: widget.indicatorAttr?.horPadding ?? 0),
                      child: Container(color: widget.indicatorAttr?.color),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int pos) {
    if (widget.itemMargin == 0 || pos == 0) {
      return widget.itemBuilder(context, pos, widget.controller.selectedIndexNotifier.value);
    } else {
      return Row(children: [SizedBox(width: widget.itemMargin), widget.itemBuilder(context, pos, widget.controller.selectedIndexNotifier.value)]);
    }
  }

  void onItemSelectChanged(int pos) {
    if (widget.controller.selectedIndexNotifier.value != pos) {
      if (widget.indicatorAttr != null) {
        anim.updateEndAndStart(pos * (widget.itemWidth + widget.itemMargin));
      }
      widget.controller.selectedIndexNotifier.value = pos;
      widget.onSelectChanged(pos);
      autoScroll(pos);
    }
  }

  void onUpdate() {
    if (anim.animation != null) {
      leftNotifier.value = anim.animation!.value;
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

class IndicatorAttr {
  IndicatorAttr({
    required this.color,
    required this.height,
    this.horPadding = 0,
  });

  final Color color;
  final double height;
  final double horPadding;
}

class IndicatorTabController {
  IndicatorTabController({int defSelectPos = 0}) {
    selectedIndexNotifier.value = defSelectPos;
  }

  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  void onItemSelectChanged(int pos) {
    selectedIndexNotifier.value = pos;
  }
}
