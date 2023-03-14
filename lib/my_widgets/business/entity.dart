import 'package:flutter/cupertino.dart';

class PicSelectorEntity {
  final String selectedPic;
  final String unselectedPic;

  PicSelectorEntity(this.selectedPic, this.unselectedPic);
}

class AutoScrollEntity {
  final ScrollController scrollController;
  final num parentHeight;
  late num contentHeight;
  final double itemMargin;
  final int size;
  final double itemHeight;

  AutoScrollEntity({
    required this.scrollController,
    required this.parentHeight,
    required this.size,
    required this.itemMargin,
    required this.itemHeight,
  }) {
    contentHeight = size * itemHeight + (size - 1) * itemMargin;
  }
}
