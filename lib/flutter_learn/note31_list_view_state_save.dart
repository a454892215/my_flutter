import 'package:flutter/material.dart';
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
  final ValueNotifier<double> heightNotifier = ValueNotifier<double>(5.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("ListView状态保存验证"),
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xffff9ef0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                AppBar(title: const Text("ListView状态保存验证")),
                ElevatedButton(
                    onPressed: () {
                      showListDialog();
                    },
                    child: const Text("dialog listview")),
                ElevatedButton(
                    onPressed: () {
                      if (heightNotifier.value < 160) {
                        heightNotifier.value += 5;
                      }
                    },
                    child: const Text("增加高度...")),
                Column(
                  children: [
                    getItem1(),
                    getItem2(),
                    getItem1(),
                    getItem2(),
                    buildDialogContent(),
                  ],
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: ValueListenableBuilder(
                  valueListenable: heightNotifier,
                  builder: (a, b, c) {
                    print("===ValueListenableBuilder=${heightNotifier.value}===");
                    return SizedBox(
                      width: 200,
                      height: heightNotifier.value,
                      child: FittedBox(fit: BoxFit.cover, clipBehavior: Clip.hardEdge, child: buildDialogContent()),
                    );
                  },
                )),
            // Container(width: double.infinity, height: double.infinity, color: const Color(0x88000000)),
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
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 160,
          width: 200,
          child: _buildListView(),
        ));
    return widget2!;
  }

  Widget _buildListView() {
    Log.d("=====_buildListView======");
    return ListView.builder(
        itemCount: 20,
        controller: ScrollController(),
        padding: const EdgeInsets.all(0),
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

  Widget? item1;

  Widget getItem1() {
    item1 ??= Container(width: 120, height: 20, color: Colors.blue);
    return item1!;
  }

  Widget? item2;

  Widget getItem2() {
    item2 ??= Container(width: 120, height: 20, color: Colors.yellow);
    return item2!;
  }
}
