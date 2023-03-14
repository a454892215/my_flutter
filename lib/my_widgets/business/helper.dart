
import 'package:flutter/cupertino.dart';

import 'entity.dart';


/// 垂直滚动组件 把选中的itemView 滚动到中间
void autoScroll(AutoScrollEntity entity, int selectedPos) {
  num height = entity.contentHeight < entity.parentHeight ? entity.contentHeight : entity.parentHeight;
  num selectedItemOriTop = selectedPos * (entity.itemMargin + entity.itemHeight);
  var offset = entity.scrollController.offset;
  num itemTop = selectedItemOriTop - offset;
  double itemCenter = height / 2 - itemTop - entity.itemHeight / 2;
  num realNeedScrollDistance = 0;
  if (itemCenter < 0) {
    num canToTopMaxScroll = entity.contentHeight - height;
    num canToTopScroll = canToTopMaxScroll - offset;
    realNeedScrollDistance = canToTopScroll < itemCenter.abs() ? -canToTopScroll : itemCenter;
  } else {
    double canToBottomScroll = offset;
    realNeedScrollDistance = canToBottomScroll < itemCenter.abs() ? canToBottomScroll : itemCenter;
  }
  entity.scrollController.animateTo(offset - realNeedScrollDistance, duration: const Duration(milliseconds: 200), curve: Curves.linear);
}

