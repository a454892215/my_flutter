import 'package:flutter/material.dart';

import '../util/Log.dart';
import '../util/toast_util.dart';

main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "FloatActionSample",
      home: FloatActionSamplePage(),
    );
  }
}

class FloatActionSamplePage extends StatelessWidget {
  const FloatActionSamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Float_Action_button_Sample"),
        ),

        /// 配置 FloatingActionButton
        floatingActionButton: buildFloatingActionButton(),

        /// endFloat 默认值  centerFloat-底部中心, startFloat-底部右边， centerFloat-底部右边不悬浮...
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        /// 悬浮按钮底部按钮组
        persistentFooterButtons: const [
          Text("按钮"),
          Text("按钮"),
        ],

        ///配置左侧侧滑页面
        drawer: buildLeftMenu(context),
        endDrawer: Container(
          color: Colors.yellow,
          width: 300,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return buildBody(context);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "主页"),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "信息"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "设置")
          ],
        ));
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Toast.show("FloatingActionButton Sample");
      },
      // 鼠标悬停提示
      tooltip: "自带提示...",
      backgroundColor: Colors.red,
      // focusColor not work?
      focusColor: Colors.green,
      //ok
      hoverColor: Colors.yellow,
      splashColor: Colors.purple,
      // child的图标颜色
      foregroundColor: Colors.white,
      elevation: 20,
      child: const Icon(Icons.add),
    );
  }

  Container buildLeftMenu(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: 400,
      child: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Toast.show("左边侧滑菜单内的按钮 被点击");
                Log.d("左边侧滑菜单内的按钮 被点击");

                /// 第1种关闭侧滑菜单方式:  Scaffold.of() called with a context that does not contain a Scaffold.
                // Scaffold.of(context).closeDrawer();

                /// 第2种关闭侧滑菜单方式, 默认点击侧滑菜单空白处，会关闭侧滑菜单，不会触发此回调...
                Navigator.of(context).pop();
              },
              child: const Text(
                "关闭菜单",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Center buildBody(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Toast.show("左边侧滑菜单开关 被点击");
              Log.d("左边侧滑菜单开关 被点击");
              if (Scaffold.of(context).isDrawerOpen) {
                /// 第1种关闭侧滑菜单方式
                // Scaffold.of(context).closeDrawer();
                /// 第2种关闭侧滑菜单方式, 默认点击侧滑菜单空白处，会关闭侧滑菜单，不会触发此回调...
                Navigator.of(context).pop();
              } else {
                Scaffold.of(context).openDrawer();
              }
            },
            child: const Text("左边侧滑菜单开关"),
          ),
          TextButton(
            onPressed: () {
              if (Scaffold.of(context).isEndDrawerOpen) {
                //Scaffold.of(context).closeEndDrawer();
                Navigator.of(context).pop();
              } else {
                Scaffold.of(context).openEndDrawer();
              }
            },
            child: const Text("右边侧滑菜单开关"),
          ),
        ],
      ),
    );
  }
}
