import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_lib_3/my_widgets/scrollable_pos_list/scrollable_positioned_list_my.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../my_widgets/horizontal_tab_group.dart';

class IndexedStackTestWidget extends StatefulWidget {
  const IndexedStackTestWidget({Key? key}) : super(key: key);

  @override
  MyWidgetState createState() => MyWidgetState();
}

ScrollController scrollController = ScrollController();
ListObserverController observerController = ListObserverController(controller: scrollController);

class MyWidgetState extends State<IndexedStackTestWidget> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final selectedIndex = 0.obs;
  final double itemWidth = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("IndexedStack 验证"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              HorizontalTabGroup(
                size: 3,
                itemBuilder: _buildIndicatorTabItemBuilder,
                width: 250,
                height: 60,
                itemWidth: itemWidth,
                itemMargin: 10,
                onSelectChanged: (pos) {
                  selectedIndex.value = pos;
                },
                bgColor: Colors.orange,
                alignment: Alignment.center,
                indicatorAttr: IndicatorAttr(color: Colors.red, height: 3, horPadding: 19),
                controller: IndicatorTabController(),
              ),
              Expanded(
                child: Obx(() {
                  return IndexedStack(
                    index: selectedIndex.value,
                    children: const [
                      ItemPageWidget(
                        bgColor: Color(0xffffc6c6),
                        size: 5,
                      ),
                      ItemPageWidget(
                        bgColor: Color(0xffc1ef9b),
                        size: 8,
                      ),
                      ItemPageWidget(
                        bgColor: Color(0xff757ee5),
                        size: 30,
                      )
                    ],
                  );
                }),
              ),
            ],
          ),
        ));
  }

  Widget _buildIndicatorTabItemBuilder(BuildContext context, int index, int selectedPos) {
    bool selected = index == selectedPos;
    Color color = selected ? Colors.white : Colors.black;
    return Container(
      width: itemWidth,
      color: selected ? Colors.blue : Colors.grey,
      child: Center(
        child: Text(
          "tab-$index",
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}

class ItemPageWidget extends StatelessWidget {
  const ItemPageWidget({
    super.key,
    required this.bgColor,
    required this.size,
  });

  final Color bgColor;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: ListView.builder(
          itemCount: size,
          physics: const BouncingScrollPhysics(),
          controller: ScrollController(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.all(10),
              color: index % 2 == 0 ? Colors.blue : Colors.amberAccent,
            );
          }),
    );
  }
}
