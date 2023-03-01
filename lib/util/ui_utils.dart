import 'package:flutter/material.dart';

typedef WidgetCreate = Widget Function(BuildContext context, int index);

class UIUtil {
  /// 获取 EmptyBoxByHeight
  static Widget getEmptyBoxByHeight(double height) {
    return SizedBox(width: 0, height: height);
  }

  static Container buildContainer(int listIndex) {
    return Container(
      height: 50,
      color: Colors.primaries[(listIndex) % Colors.primaries.length],
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 4),
      child: Text(
        '$listIndex',
        style: const TextStyle(color: Colors.black, fontSize: 10),
      ),
    );
  }

  /// 获取 ListView
  static ListView buildListView(int count, WidgetCreate widgetCreate) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return widgetCreate(context, index);
      },
      itemCount: count,
    );
  }

  /// SliverFixedExtentList
  static Widget buildSliverFixedExtentList(WidgetCreate widgetCreate, [int count = 5, double height = 50]) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return widgetCreate(context, index);
        },
        childCount: count,
      ),

      /// item高度
      itemExtent: height,
    );
  }

  static SliverGrid buildSliverGrid(
      WidgetCreate widgetCreate,
      [int childCount = 20,
      int crossAxisCount = 3,
      double childAspectRatio = 1,
      double mainAxisSpacing = 8,
      double crossAxisSpacing = 8]) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
            childCount: childCount,
            (context, index) => widgetCreate(context, index)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,

          /// 根据比例决主轴显示的高度：1：即宽高比相同， 2：宽高比为2
          /// 在横轴确定个数后，纵轴的高度由可以用childAspectRatio指定比例
          childAspectRatio: childAspectRatio,

          /// 主方向间距
          mainAxisSpacing: mainAxisSpacing,

          /// 交轴方向间距
          crossAxisSpacing: crossAxisSpacing,
        ));
  }
}
