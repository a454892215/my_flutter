import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/toast_util.dart';

/// 1. 设置控件宽高使用 使用：SizedBox()
/// 2. 设置控件背景颜色  使用：Container()
/// 3. Text 常见属性用法
/// 4. const Text.rich 用法示例
class TextSamplePage extends StatefulWidget {
  const TextSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return TextSamplePageState();
  }
}

class TextSamplePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TextSamplePage")),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              width: 0,
              height: 10,
            ),
            buildSizedBox1(),
            const SizedBox(
              width: 0,
              height: 10,
            ),
            buildSizedBox2(),
            const SizedBox(
              width: 0,
              height: 10,
            ),
            buildSizedBox3(),
            const SizedBox(
              width: 0,
              height: 10,
            ),
            buildSizedBox4(),
          ],
        ),
      ),
    );
  }

  SizedBox buildSizedBox1() {
    return SizedBox(
      width: 120,
      height: 80,
      child: Container(
        color: Colors.blueGrey,
        child: const Text(
          "我是文本文本文本 word words I am a person",
          // TextAlign.center 父组件中水平居中
          // TextAlign.start 父组件中从左对齐
          // TextAlign.justify 拉升最后一行文本， 以填充宽度， 使用
          textAlign: TextAlign.start,
          maxLines: 3,
          // TextOverflow.clip：文本超出裁剪掉，默认
          // TextOverflow.ellipsis：文本超出裁剪掉,显示省略号
          // TextOverflow.fade：文本超出裁则透明化
          overflow: TextOverflow.ellipsis,
          // 文本超过控件的文本，是否换行
          softWrap: true,
          // 设置文本绘制方向，从左边到右边，默认
          textDirection: TextDirection.ltr,
          // 设置文字样式，大小颜色等
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            // decoration 设置文本的上划线，中划线，下划线，无线
            decoration: TextDecoration.underline,
            decorationColor: Colors.black,
            decorationStyle: TextDecorationStyle.solid,
            // decoration 线粗细
            decorationThickness: 4,
            // 文本行高度倍数
            height: 1.9,
            // 文字粗细
            fontWeight: FontWeight.normal,
            // 设置文字是否斜体
            fontStyle: FontStyle.italic,
            // 设置单个文字的距离（比如汉字 单词）
            letterSpacing: 2,
            // 设置单词间距（对汉字不生效）
            wordSpacing: 2,

            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBox2() {
    return SizedBox(
      width: 120,
      height: 120,
      child: Container(
        color: const Color.fromARGB(255, 222, 255, 182),

        /// 内容居中 Alignment坐标系中，中心位置为x,y轴的原点位置
        alignment: const Alignment(0, 0),
        child: const Text(
          "居中文本",
          //textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: TextStyle(backgroundColor: Colors.blue),
        ),
      ),
    );
  }

  SizedBox buildSizedBox3() {
    return SizedBox(
      width: 120,
      height: 40,
      child: Container(
        color: const Color.fromARGB(255, 222, 255, 182),
        child: const Text(
          "我是文本我是文本我是文本",

          textAlign: TextAlign.justify,
          // 设置文本缩放大小
          textScaleFactor: 0.9,
          maxLines: 3,
          style: TextStyle(backgroundColor: Colors.blue),
        ),
      ),
    );
  }

  SizedBox buildSizedBox4() {
    return SizedBox(
      width: 120,
      height: 180,
      child: Container(
        color: const Color.fromARGB(255, 119, 119, 119),
        child:  Text.rich(TextSpan(
          text: "我是TextSpan1 ",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          children: [
            TextSpan(
              text: "我是TextSpan2 ",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
              // 设置点击事件
              recognizer: TapGestureRecognizer()..onTap=(){
                 Toast.show("我是TextSpan2 ");
              },
            ),
            const TextSpan(
              text: "我是TextSpan3 ",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 12,
              ),
            ),
            const TextSpan(
              text: "我是TextSpan4 ",
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
