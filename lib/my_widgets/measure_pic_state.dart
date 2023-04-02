import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class SinglePicMeasureState<T extends StatefulWidget> extends State<T> {
  String getPicPath();

  late PicMeasureItem item;

  @override
  void initState() {
    super.initState();
    item = PicMeasureItem(getPicPath());
    item.init();
  }

  @override
  void dispose() {
    item.dispose();
    super.dispose();
  }
}

class PicMeasureItem {
  final GlobalKey picGlobalKey = GlobalKey();
  ImageStream? _imageStream;
  final String _picPath;
  double picWidth = 0;
  /// 此值需要在picHeightWidthRadio获取后 再刷新UI获取，第一次加载或有明显延迟
  final picHeight = 0.0.obs;
  /// 使用此值无明显延迟
  final picHeightWidthRadio= 0.0.obs;

  PicMeasureItem(this._picPath);

  void init() {
    _imageStream = AssetImage(_picPath).resolve(ImageConfiguration.empty);
    _imageStream!.addListener(ImageStreamListener(_onImageLoaded));
  }

  void dispose() {
    _imageStream!.removeListener(ImageStreamListener(_onImageLoaded));
  }

  void _onImageLoaded(ImageInfo imageInfo, bool synchronousCall) {
    picHeightWidthRadio.value = imageInfo.image.height.toDouble() / imageInfo.image.width;

    /// 如果widget中有多张影响其大小的图片 则需要在最后一张图片加载完成后再设置其监听
    /// 在获取图片大小后再添加监听，然后刷新
    WidgetsBinding.instance.addPostFrameCallback(afterLayout);
    picHeight.value = 0.01;
  }

  void afterLayout(Duration duration) {
    final RenderObject? object = picGlobalKey.currentContext?.findRenderObject();
    if (object != null) {
      RenderBox renderBox = object as RenderBox;
      final size = renderBox.size;
      picWidth = size.width;
      picHeight.value = size.height;
    }
  }
}
