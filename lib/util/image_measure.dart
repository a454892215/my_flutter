import 'package:flutter/cupertino.dart';

typedef SizeCallback = void Function(Size size);

void getNetworkImageSize(String imageURL, SizeCallback callback) {
  Image image = Image.network(imageURL);
  listenerSize(image, callback);
}

void getAssertImageSize(String assertPath, SizeCallback callback) {
  Image image = Image.asset(assertPath);
  listenerSize(image, callback);
}

void listenerSize(Image image, SizeCallback callback) {
  image.image.resolve(const ImageConfiguration()).addListener(
    ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        var myImage = image.image;
        Size imageSize = Size(myImage.width.toDouble(), myImage.height.toDouble());
        callback(imageSize);
      },
    ),
  );
}
