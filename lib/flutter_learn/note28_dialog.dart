import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my_widgets/bottom_drawer.dart';
import '../my_widgets/comm_dialog.dart';
import '../my_widgets/pop_window.dart';
import '../util/toast_util.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: DialogSamplePage(),
  ));
}

class DialogSamplePage extends StatefulWidget {
  const DialogSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  var drawerController = DrawerController2();
  PopWindow popWindow = PopWindow();

  @override
  Widget build(BuildContext context) {
    popWindow.init(
        context,
        Container(
          width: 300,
          height: 200,
          color: Colors.blue,
          alignment: Alignment.center,
          child: ListView(
            key: UniqueKey(),
            padding: EdgeInsets.zero,
            children: List.generate(
                30,
                (index) => Center(
                      child: Text("index-$index"),
                    )),
          ),
        ),
        200);
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              AppBar(title: const Text("Dialog-Test")),
              ElevatedButton(
                  child: const Text("底部弹窗1"),
                  onPressed: () {
                    _showBottomDialog(back: true);
                  }),
              ElevatedButton(
                  child: const Text("自定义的嵌套当前页面的底部弹窗"),
                  onPressed: () {
                    drawerController.showOrDismiss();
                  }),
              ElevatedButton(
                  child: const Text("overlay-popWindow"),
                  onPressed: () {
                    popWindow.show();
                  }),
              ElevatedButton(
                  child: const Text("右边弹窗"),
                  onPressed: () {
                    Toast.show("右边弹窗");
                  }),
              ElevatedButton(
                  child: const Text("中间弹窗"),
                  onPressed: () {
                    Toast.show("中间弹窗");
                  }),
            ],
          ),
          Positioned(
              bottom: 0,
              child: LayoutBuilder(
                builder: (context, constraintType) {
                  return BottomDrawer(
                    height: 200,
                    controller: drawerController,
                    child: Container(
                      height: 200,
                      width: 300,
                      color: Colors.blue,
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }

  Container buildPopWindowWidget(double bottomWidgetHeight) {
    return Container(
      width: 300,
      height: bottomWidgetHeight,
      color: Colors.blue,
      alignment: Alignment.center,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Container(
              height: 30,
              alignment: Alignment.center,
              child: Text("text-$index"),
            );
          }),
    );
  }

  void _showBottomDialog({bool back = true}) {
    bottomDialog(
        back: back,
        child: Container(
          height: 400,
          color: Colors.blue,

          ///1. 如果换成ListView 不能拖动侧滑菜单关闭
          child: Column(
            children: [
              MaterialButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("离开弹窗"),
              )
            ],
          ),
        ));
  }
}
