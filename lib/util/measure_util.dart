import 'package:flutter/material.dart';

class WidgetSizeHelper {
  GlobalKey globalKey = GlobalKey();


  Size getSize() {
    final RenderObject? object = globalKey.currentContext?.findRenderObject();
    if (object != null) {
      RenderBox renderBox = object as RenderBox;
      final size = renderBox.size;
      return Size(size.width, size.height);
    }
    return const Size(0, 0);
  }
}