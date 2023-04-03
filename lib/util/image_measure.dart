import 'package:flutter/cupertino.dart';

typedef SizeCallback = void Function(Size size);

class ImageMeasureHelper {
  ImageStream? stream;
  final SizeCallback callback;
  late ImageStreamListener listener = ImageStreamListener(onListener);

  ImageMeasureHelper(this.callback);

  void getNetworkImageSize(String imageURL) {
    Image image = Image.network(imageURL);
    listenerSize(image);
  }

  void getAssertImageSize(String assertPath) {
    Image image = Image.asset(assertPath);
    listenerSize(image);
  }

  void listenerSize(Image image) {
    stream = image.image.resolve(const ImageConfiguration());
    stream?.addListener(listener);
  }

  void onListener(ImageInfo image, bool synchronousCall) {
    var myImage = image.image;
    Size imageSize = Size(myImage.width.toDouble(), myImage.height.toDouble());
    callback(imageSize);
  }

  void close() {
    stream?.removeListener(listener);
  }
}
