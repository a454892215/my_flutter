import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_lib_3/my_widgets/loop_scroll_widget.dart';
import 'package:my_flutter_lib_3/my_widgets/scrollable_pos_list/scrollable_positioned_list_my.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class LoopScrollTestWidget extends StatefulWidget {
  const LoopScrollTestWidget({Key? key}) : super(key: key);

  @override
  LoopScrollTestWidgetState createState() => LoopScrollTestWidgetState();
}

ScrollController scrollController = ScrollController();
ListObserverController observerController = ListObserverController(controller: scrollController);

class LoopScrollTestWidgetState extends State<LoopScrollTestWidget> {
  final ItemScrollController itemScrollController = ItemScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("循环滚动组建"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                height: 120.w,
                width: 660.w,
                child: LoopScrollWidget(
                  itemCount: 6,
                  itemMargin: 12.w,
                  itemScrollController: itemScrollController,
                  itemBuilder: (BuildContext context, int realItemIndex, int dataItemIndex) {
                    return CupertinoButton(
                      minSize: 0,
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        itemScrollController.scrollTo(
                          index: realItemIndex,
                          alignment: 0.4,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Container(
                        width: 160.w,
                        height: double.infinity,
                        padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 0.w, bottom: 0.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: dataItemIndex % 2 == 0 ? Colors.yellow : Colors.pink,
                          borderRadius: BorderRadius.circular(12.w),
                          border: Border.all(color: const Color(0xff000000), width: 1.w),
                        ),
                        child: Text(
                            "$dataItemIndex",
                            style: TextStyle(
                              fontSize: 24.w,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
