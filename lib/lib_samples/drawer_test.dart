import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../my_widgets/collapse.dart';

class DrawerTestWidget extends StatefulWidget {
  const DrawerTestWidget({Key? key}) : super(key: key);

  @override
  MyWidgetState createState() => MyWidgetState();
}

ScrollController scrollController = ScrollController();
ListObserverController observerController = ListObserverController(controller: scrollController);

class MyWidgetState extends State<DrawerTestWidget> {
  CollapseController collapseController = CollapseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("抽屉折叠收起效果 验证"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Collapse(
                title: Container(
                  height: 100.w,
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: const Text(
                    "你好啊",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                childSize: 3,
                widgetBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.infinity,
                    height: 100.w,
                    color: Colors.pink,
                    padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 0.w, bottom: 0.w),
                    child: Text("你好啊$index"),
                  );
                },
                collapseController: collapseController,
              ),
            ],
          ),
        ));
  }
}
