import 'package:flutter/material.dart';

main() {
  runApp(const MaterialApp(
    home: HeroDetailSample(tag: "1"),
  ));
}

///1. HeroDetailSample
class HeroDetailSample extends StatefulWidget {
  const HeroDetailSample({Key? key, required this.tag}) : super(key: key);

  final String tag;

  @override
  State createState() => _State();
}

class _State extends State<HeroDetailSample> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HeroDetailSample"),
      ),
      body: Column(
        children: [
          const Text("我是hero转场动画详情页面"),
          Container(
            color: Colors.grey,
           // height: 200,
            padding: const EdgeInsets.only(left: 12, right: 12),
            /// center隔离 使外层Container能设置size
            child: Center(
              child: Material(
                child: Hero(
                  tag: widget.tag,
                  child: Image.asset(
                    "images/js.jpeg",
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
