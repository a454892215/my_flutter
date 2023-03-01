import 'package:flutter/material.dart';

class NestedScrollWidget extends StatefulWidget {
  const NestedScrollWidget({
    Key? key,
    this.topTitle,
    this.bottomTitle,
    required this.background,
    required this.listWidget,
    this.expandedHeight = 180,
    this.collapsedHeight = 30,
    this.toolbarHeight = 30,
  }) : super(key: key);

  final Widget? topTitle;
  final Widget? bottomTitle;
  final Widget background;
  final Widget listWidget;
  final double expandedHeight;
  final double collapsedHeight;
  final double toolbarHeight;

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<NestedScrollWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          // 收起的过渡颜色
          // backgroundColor: Colors.white,
          title: widget.topTitle,
          // 去掉主标题栏左右间距
          titleSpacing: 0,
          leading: const SizedBox(),
          pinned: true,
          floating: true,
          bottom: const PreferredSize(preferredSize: Size(0, 0), child: SizedBox()),
          expandedHeight: widget.expandedHeight,
          collapsedHeight: widget.collapsedHeight,
          leadingWidth: 0,
          //  collapsedHeight >= toolbarHeight
          toolbarHeight: widget.collapsedHeight,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.all(0),
            expandedTitleScale: 1,
            collapseMode: CollapseMode.parallax,
            title: widget.bottomTitle,
            background: widget.background,
          ),
        ),
        // const SliverPadding(padding: EdgeInsets.only(top: 10)),
        widget.listWidget,
      ],
    );
  }
}
