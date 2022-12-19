import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my_widgets/bottom_drawer.dart';
import '../my_widgets/comm_dialog.dart';
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

  @override
  Widget build(BuildContext context) {
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
              ElevatedButton(child: const Text("底部弹窗2"), onPressed: () {
                drawerController.showOrDismiss();
              }),
              ElevatedButton(
                  child: const Text("左边弹窗"),
                  onPressed: () {
                    Toast.show("左边弹窗");
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
