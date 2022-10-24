import 'package:flutter/material.dart';

class UIUtil {
  /// 获取 EmptyBoxByHeight
  static Widget getEmptyBoxByHeight(double height) {
    return SizedBox(width: 0, height: height);
  }

  /// 获取 ListView
  static ListView buildListView(int count, Widget? child) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.white,
          //  padding: const EdgeInsets.only(left: 12, right: 12),
          child: child ??
              Container(
                height: 80,
                color: Colors.primaries[index % Colors.primaries.length],
                alignment: Alignment.center,
                child: Text(
                  'Test-$index',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
        );
      },
      itemCount: count,
    );
  }

  /// 7. SliverFixedExtentList
  static Widget buildSliverFixedExtentList([int count = 5, Widget? child, double height = 50]) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return child ??
              Container(
                color: Colors.primaries[(index) % Colors.primaries.length],
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '$index',
                  style: const TextStyle(color: Colors.black, fontSize: 10),
                ),
              );
        },
        childCount: count,
      ),

      /// item高度
      itemExtent: height,
    );
  }

  static SliverGrid buildSliverGrid(
      [int childCount = 20,
      Widget? child,
      int crossAxisCount = 3,
      double childAspectRatio = 1,
      double mainAxisSpacing = 8,
      double crossAxisSpacing = 8]) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
            childCount: childCount,
            (context, index) =>
                child ??
                Container(
                  // margin: const EdgeInsets.all(12),
                  color: Colors.blue,
                )),
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
