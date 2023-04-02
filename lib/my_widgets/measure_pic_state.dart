import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class SinglePicMeasureState<T extends StatefulWidget> extends State<T> {
  /// 需要添加到需要获取高度的图片控件上
  final GlobalKey picGlobalKey = GlobalKey();
  ImageStream? _imageStream;

  double picWidth = 0;
  final picHeight = 0.0.obs;

  String getPicPath();

  void afterLayout(Duration duration) {
    final RenderObject? object = picGlobalKey.currentContext?.findRenderObject();
    if (object != null) {
      RenderBox renderBox = object as RenderBox;
      final size = renderBox.size;
      picWidth = size.width;
      picHeight.value = size.height;
    }
  }

  @override
  void initState() {
    super.initState();
    _imageStream = AssetImage(getPicPath()).resolve(ImageConfiguration.empty);
    _imageStream!.addListener(ImageStreamListener(_onImageLoaded));
  }

  @override
  void dispose() {
    _imageStream!.removeListener(ImageStreamListener(_onImageLoaded));
    super.dispose();
  }

  void _onImageLoaded(ImageInfo imageInfo, bool synchronousCall) {
    // var width = imageInfo.image.width;
    // var height = imageInfo.image.height;
    /// 如果widget中有多张影响其大小的图片 则需要在最后一张图片加载完成后再设置其监听
    /// 在获取图片大小后再添加监听，然后刷新
    WidgetsBinding.instance.addPostFrameCallback(afterLayout);
  }
}
