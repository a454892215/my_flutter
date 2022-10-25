import 'package:flutter/material.dart';
/// 1. Image只有宽或者高的时候，另一边等比缩放
/// 2. BoxFit.fill, 图片缩放宽高填Image充设置大小
/// 3. BoxFit.cover, 图片保持宽高比，填满Image设置的宽高，多余部分裁剪
/// 4. BoxFit.contain 默认模式，图片保持宽高比，居中Image显示，
/// 5. BoxFit.fitWidth 图片根据Image的width等比缩放， 填充width，多余部分裁剪
/// 6. BoxFit.fitHeight 图片根据Image的Height等比缩放， 填充Height，多余部分裁剪
/// 7. 注意 Image的 alignment: Alignment.center, 默认居中
class ImageSamplePage extends StatefulWidget {
  const ImageSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StackAndWrap-示例"),
      ),
      body: ListView(
        children: [
          buildContainer1(),
        ],
      ),
    );
  }

  double itemWidth = 30;

  /// 绝对定位： Stack， Positioned
  Container buildContainer1() {
    return Container(
      height: 300,
      color: Colors.orange,
      child: Stack(
        //  StackFit.expand 没有Positioned定位的子空间填充满窗口
        // fit: StackFit.expand,
        children: [
          image1(),
          image2(),
          image3(),
          image4(),
          image5(),
          image6(),
        ],
      ),
    );
  }

  Positioned image1() {
    return Positioned(
          width: 120,
          height: 80,
          left: 10,
          top: 10,
          child: Container(
            color: Colors.pink,
            alignment: Alignment.topLeft,
            child: const Image(
              /// 只有宽或者高的时候，另一边等比缩放
              height: 50,
              image: AssetImage("images/js.jpeg"),
            ),
          ),
        );
  }
  Positioned image2() {
    return Positioned(
      width: 120,
      height: 80,
      left: 180,
      top: 10,
      child: Container(
        color: Colors.white,
        alignment: Alignment.topLeft,
        child: const Image(
          width: 110,
          height: 30,
          /// 2. BoxFit.fill, 图片缩放宽高填充设置大小
          fit: BoxFit.fill,
          image: AssetImage("images/js.jpeg"),
        ),
      ),
    );
  }
  Positioned image3() {
    return Positioned(
      width: 120,
      height: 80,
      right: 10,
      top: 10,
      child: Container(
        color: Colors.green,
        alignment: Alignment.topLeft,
        child: const Image(
          width: 110,
          height: 30,
          /// 3. BoxFit.cover, 图片保持宽高比，填满设置的宽高，多余部分裁剪
          fit: BoxFit.cover,
          image: AssetImage("images/js.jpeg"),
        ),
      ),
    );
  }
  Positioned image4() {
    return Positioned(
      width: 120,
      height: 80,
      left: 10,
      top: 120,
      child: Container(
        color: Colors.yellow,
        alignment: Alignment.topLeft,
        child: const Image(
          // width， height 超过父容器大小，会取父容器大小
          width: 110,
          height: 30,
          /// 4. BoxFit.contain 默认模式，图片保持宽高比，居中显示，
          fit: BoxFit.contain,
          image: AssetImage("images/js.jpeg"),
        ),
      ),
    );
  }
  Positioned image5() {
    return Positioned(
      width: 120,
      height: 80,
      right: 10,
      top: 120,
      child: Container(
        color: Colors.blue,
        alignment: Alignment.topLeft,
        child: const Image(
          // width， height 超过父容器大小，会取父容器大小
          width: 110,
          height: 30,
          /// 5. BoxFit.fitWidth 图片根据Image的width等比缩放， 填充width，多余部分裁剪
          fit: BoxFit.fitWidth,
          image: AssetImage("images/js.jpeg"),
        ),
      ),
    );
  }
  Positioned image6() {
    return Positioned(
      width: 120,
      height: 80,
      left: 180,
      bottom: 10,
      child: Container(
        color: Colors.green,
        alignment: Alignment.topLeft,
        child: const Image(
          // width， height 超过父容器大小，会取父容器大小
          width: 110,
          height: 30,
          /// 6. BoxFit.fitHeight 图片根据Image的Height等比缩放， 填充Height，多余部分裁剪
          fit: BoxFit.fitHeight,
          alignment: Alignment.topLeft,
          image: AssetImage("images/js.jpeg"),
        ),
      ),
    );
  }
}
