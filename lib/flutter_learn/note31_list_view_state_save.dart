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
  final ValueNotifier<double> heightNotifier = ValueNotifier<double>(0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView状态保存验证"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xffff9ef0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ElevatedButton(
                onPressed: () {
                  showListDialog();
                },
                child: const Text("dialog listview")),
            Positioned(
              top: 40,
              child: ElevatedButton(
                  onPressed: () {
                    if (heightNotifier.value < 300) {
                      heightNotifier.value += 20;
                    }
                  },
                  child: const Text("增加高度...")),
            ),
            Positioned(
                bottom: 0,
                child: ValueListenableBuilder(
                  valueListenable: heightNotifier,
                  builder: (a, b, c) {
                    print("===ValueListenableBuilder====");
                    return Container(
                      width: 200,
                      height: heightNotifier.value,
                      color: Colors.yellow,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        clipBehavior: Clip.antiAlias,
                        child: SizedBox(
                          width: 200,
                          height: 300,
                          child: _buildListView(),
                        ),
                      ),
                    );
                  },
                ))
          ],
        ),
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

  Widget _buildListView() {
    return ListView.builder(
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
  }
}
