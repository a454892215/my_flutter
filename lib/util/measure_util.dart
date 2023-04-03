import 'package:flutter/material.dart';

typedef SizeCallback = void Function(Size size);

class WidgetSizeHelper {
  GlobalKey globalKey = GlobalKey();

  void addListener(SizeCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      var size = getSize();
      callback(size);
    });
  }

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
