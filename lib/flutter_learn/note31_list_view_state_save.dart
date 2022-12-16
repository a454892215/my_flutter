import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/keep_alive_page.dart';
import 'package:my_flutter_lib_3/my_widgets/scroll_radio_group.dart';

import '../my_widgets/indicator_tab_group.dart';
import '../util/Log.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: ListViewStateSaveTestPage(),
  ));
}

class ListViewStateSaveTestPage extends StatefulWidget {
  const ListViewStateSaveTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  final double itemWidth = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView状态保存验证"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showListDialog();
              },
              child: const Text("dialog listview")),
        ],
      ),
    );
  }

  void showListDialog() {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return buildDialogContent();
        });
  }

  Widget? widget2;

  Widget buildDialogContent() {
    widget2 ??= Align(
        alignment: Alignment.bottomLeft,
        child: SizedBox(
          height: 300,
          child: PageView(
            children: [
              keepAlivePage(
                _buildListView(),
              )
            ],
          ),
        ));
    return widget2!;
  }

  ListView? listView;

  Widget _buildListView() {
    // Log.d("====$listView=====");
    listView ??= ListView.builder(
        restorationId: '2',
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            height: 50,
            color: index % 2 == 0 ? Colors.red : Colors.blue,
            child: Text(
              "Pos-$index",
              style: const TextStyle(fontSize: 13, color: Colors.white),
            ),
          );
        });
    return listView!;
  }
}
