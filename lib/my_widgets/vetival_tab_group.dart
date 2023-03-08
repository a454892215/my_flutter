import 'package:flutter/material.dart';
import 'comm_anim2.dart';

typedef ItemBuilder = Widget Function(BuildContext context, int index, int selectedPos);
typedef Callback<T> = void Function(T t);

class VerticalTabGroup extends StatefulWidget {
  const VerticalTabGroup({
    super.key,
    required this.size,
    required this.itemBuilder,
    this.itemMargin = 0,
    this.bgColor,
    this.alignment = Alignment.topLeft,
    required this.width,
    required this.height,
    required this.itemHeight,
    required this.onSelectChanged,
    required this.controller,
  });

  final int size;
  final ItemBuilder itemBuilder;
  final double itemMargin;
  final double width;
  final double height;
  final double itemHeight;
  final Callback<int> onSelectChanged;
  final Color? bgColor;
  final Alignment alignment;
  final VerticalTabController controller;

  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State<VerticalTabGroup> with TickerProviderStateMixin {
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
          scrollDirection: Axis.vertical,
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ValueListenableBuilder(
                valueListenable: widget.controller.selectedIndexNotifier,
                builder: (BuildContext context, int value, Widget? child) {
                  return Column(
                    children: List.generate(widget.size, (pos) {
                      return GestureDetector(
                        onTap: () => onItemSelectChanged(pos),
                        child: _buildItem(context, pos),
                      );
                    }),
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
      return Column(children: [SizedBox(height: widget.itemMargin), widget.itemBuilder(context, pos, widget.controller.selectedIndexNotifier.value)]);
    }
  }

  void onItemSelectChanged(int pos) {
    if (widget.controller.selectedIndexNotifier.value != pos) {
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
    double parentHeight = rootKey.currentContext?.size?.height ?? widget.height;
    double contentHeight = widget.size * widget.itemHeight + (widget.size - 1) * widget.itemMargin;
    double height = contentHeight < parentHeight ? contentHeight : parentHeight;
    double selectedItemOriTop = selectedPos * (widget.itemMargin + widget.itemHeight);
    var offset = scrollController.offset;
    double itemTop = selectedItemOriTop - offset;
    double itemCenter = height / 2 - itemTop - widget.itemHeight / 2;
    double realNeedScrollDistance = 0;
    if (itemCenter < 0) {
      double canToTopMaxScroll = contentHeight - height;
      double canToTopScroll = canToTopMaxScroll - offset;
      realNeedScrollDistance = canToTopScroll < itemCenter.abs() ? -canToTopScroll : itemCenter;
    } else {
      // 向右边滚动
      double canToBottomScroll = offset;
      realNeedScrollDistance = canToBottomScroll < itemCenter.abs() ? canToBottomScroll : itemCenter;
    }
    scrollController.animateTo(offset - realNeedScrollDistance, duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }
}

class VerticalTabController {
  VerticalTabController({int defSelectPos = 0}) {
    selectedIndexNotifier.value = defSelectPos;
  }

  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  void onItemSelectChanged(int pos) {
    selectedIndexNotifier.value = pos;
  }
}
