import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../util/Log.dart';

/// 同时支持头部加载更多和底部加载更多
/// 加载更多item的显示加载逻辑：
/// 加载更多的itemView始终显示在最后一个item上，
/// 加载更多触发加载逻辑：当不足一视口的时候，加载更多点击触发（可配置不足一个视口是否需要点击加载更多） ，当超过一视口的时候 加载更多显示触发,
/// 当最后的itemView的TrailingEdge值小于1并且显示的itemView数目等于数据size 则内容没有超过一视口。否则则超过了一个视口

class LoadMoreFunc {
  late List<dynamic> list;
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  bool isAddLoadMoreItemViewOnLessOneViewport = false;

  void initListener() {
    itemPositionsListener.itemPositions.addListener(() {
      List<ItemPosition> list = itemPositionsListener.itemPositions.value.toList();
      for (int i = 0; i < list.length; i++) {
        ItemPosition item = list[i];
        var index = item.index;
        var itemLeadingEdge = item.itemLeadingEdge;
        var itemTrailingEdge = item.itemTrailingEdge;
        Log.d("pis:$i  index:$index  itemLeadingEdge:$itemLeadingEdge  itemTrailingEdge:$itemTrailingEdge");
      }
      Log.d("list :$list");
    });
  }

  void setList(List<dynamic> list) {
    this.list = list;
  }

  void initItemScrollListener() {}
}

class LoadMoreWidget extends StatelessWidget {
  const LoadMoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 60,
      child: Text(
        "加载更多",
        style: TextStyle(color: Color(0xffffffff)),
      ),
    );
  }
}
