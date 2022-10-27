import 'package:flutter/material.dart';

import 'note211_hero_detail_anim.dart';

main() {
  runApp(const MaterialApp(
    home: HeroSample(),
  ));
}

///1. RotationTransition
class HeroSample extends StatefulWidget {
  const HeroSample({Key? key}) : super(key: key);

  @override
  State createState() => _SizeTransitionDemoState();
}

class _SizeTransitionDemoState extends State with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hero anim"),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            String tag = "tag_$index";
            return GestureDetector(
              child: Column(
                children: [
                  const Text("我是hero转场动画示例..."),

                  /// 1.如果把text也包裹进去 专场动画很奇怪，不能包裹Text?
                  HeroMode(
                    ///是否启用 hero动画
                    enabled: false,
                    child: Hero(
                      tag: tag,
                      child: Material(
                        child: Image.asset(
                          "images/js.jpeg",
                          height: 110,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                // switchPage1(context, tag);
                switchPage2(context, tag);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(top: 12, bottom: 12),
              child: const Divider(
                color: Colors.grey,
                thickness: 12,
              ),
            );
          },
          itemCount: 30),
    );
  }

  ///1. 简单方式切换转场页面
  void switchPage1(BuildContext context, String tag) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return HeroDetailSample(tag: tag);
    }));
  }

  ///2. 自定义时间 动画方式切换转场动画
  void switchPage2(BuildContext context, String tag) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return HeroDetailSample(tag: tag);
      },
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder:
          (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          ///1. 定义动画速率变化和 透明度变化
          opacity: Tween<double>(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut)),
          child: child,
        );
      },
    ));
  }
}
