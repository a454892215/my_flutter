import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

String summary = '''
1. Image只有宽或者高的时候，另一边等比缩放：

2. Image的 fit 模式：
      01. BoxFit.fill, 图片缩放宽高填Image充设置大小
      02. BoxFit.cover, 图片保持宽高比，填满Image设置的宽高，多余部分裁剪
      03. BoxFit.contain 默认模式，图片保持宽高比，居中Image显示，
      04. BoxFit.fitWidth 图片根据Image的width等比缩放， 填充width，多余部分裁剪
      05. BoxFit.fitHeight 图片根据Image的Height等比缩放， 填充Height，多余部分裁剪
      06. Image的 alignment: Alignment.center, 默认居中

3. Image的 colorBlendMode 设置图片混色模式

4. Image加载网络图片. 
      01. Image.network("path"):  加载网络图片
      02. FadeInImage.assetNetwork(placeholder: "images/xx.jpeg", image: imgUrl)
      03. CachedNetworkImage 第三方框架加载图片
''';

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
          Text(
            summary,
            softWrap: true,
            style: const TextStyle(color: Colors.black, fontSize: 13),
          )
        ],
      ),
    );
  }

  double itemWidth = 30;

  Container buildContainer1() {
    return Container(
      height: 200,
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
        ],
      ),
    );
  }

  /// 1. 只有宽或者高的时候，另一边等比缩放
  Positioned image1() {
    return Positioned(
      width: 100,
      height: 80,
      left: 10,
      top: 10,
      child: Stack(
        children: [
          Container(
            color: Colors.pink,
            alignment: Alignment.topLeft,
            child: const Image(
              /// 1. 只有宽或者高的时候，另一边等比缩放
              height: 50,
              image: AssetImage("images/js.jpeg"),
            ),
          ),
          const Positioned(
            bottom: 3,
            left: 3,
            child: Text(
              "only height",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  /// 2.Image fit 属性 设置图片缩放模式
  Positioned image2() {
    return Positioned(
      width: 100,
      height: 80,
      left: 120,
      top: 10,
      child: Container(
        color: Colors.white,
        alignment: Alignment.topLeft,
        child: const Image(
          width: 90,
          height: 30,

          /// 2. BoxFit.fill, 图片缩放宽高填Image充设置大小
          /// 3. BoxFit.cover, 图片保持宽高比，填满Image设置的宽高，多余部分裁剪
          /// 4. BoxFit.contain 默认模式，图片保持宽高比，居中Image显示，
          /// 5. BoxFit.fitWidth 图片根据Image的width等比缩放， 填充width，多余部分裁剪
          /// 6. BoxFit.fitHeight 图片根据Image的Height等比缩放， 填充Height，多余部分裁剪
          /// 7. 注意 Image的 alignment: Alignment.center, 默认居中
          fit: BoxFit.fill,
          image: AssetImage("images/js.jpeg"),
        ),
      ),
    );
  }

  /// 3. Image的 colorBlendMode 设置图片混色模式
  Positioned image3() {
    return Positioned(
      width: 100,
      height: 80,
      right: 10,
      top: 10,
      child: Container(
        color: const Color(0xffa4ff3c),
        alignment: Alignment.topLeft,
        child: const Image(
          fit: BoxFit.fitWidth,
          color: Colors.red,
          // 颜色混合模式
          colorBlendMode: BlendMode.hue,
          image: AssetImage("images/js.jpeg"),
        ),
      ),
    );
  }

  String imgUrl =
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Flmg.jj20.com%2Fup%2Fallimg%2F1114%2F010421142927%2F210104142927-8-1200."
      "jpg&refer=http%3A%2F%2Flmg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1669270662&t=03ce40a177b79c646757c80de0f9ed74";

  /// 4.  Image加载网络图片.
  ///  01. AssetImage("images/js.jpeg") 加载本地图片
  ///  02. Image.asset("images/xx.jpeg") 加载本地图片
  ///  03. Image.network("path"):  加载网络图片
  ///  04. FadeInImage.assetNetwork(placeholder: "images/js.jpeg", image: imgUrl) // 带展位图加载图片
  ///  05. ClipOval(child: null,) ClipRect() 裁剪widget
  ///  06. CircleAvatar() 圆角图片...
  Positioned image4() {
    return Positioned(
      width: 100,
      height: 80,
      left: 10,
      bottom: 10,
      child: Container(
        color: const Color(0xffa4ff3c),
        alignment: Alignment.topLeft,
        // child: Image.network(imgUrl),
        child: FadeInImage.assetNetwork(placeholder: "images/js.jpeg", image: imgUrl),
      ),
    );
  }

  // 5 第三方框架（cached_network_image: ^3.2.2） CachedNetworkImage 加载图片
  Positioned image5() {
    return Positioned(
      width: 100,
      height: 80,
      right: 10,
      bottom: 10,
      child: Container(
        color: const Color(0xffa4ff3c),
        alignment: Alignment.topLeft,
        // child: Image.network(imgUrl),
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
