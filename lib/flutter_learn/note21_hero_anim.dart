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
                  Hero(
                    tag: tag,
                    child: Material(
                      child: Image.asset(
                        "images/js.jpeg",
                        height: 110,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return HeroDetailSample(tag: tag);
                }));
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
}
