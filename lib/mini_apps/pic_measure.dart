import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/material.dart';

import '../globe_exception_catch.dart';
import '../main.dart';

main() {
  GlobeExceptionHandler().init(() => runApp(buildScreenUtilInit(child: getMaterialApp())));
}

Widget getMaterialApp() {
  return const GetMaterialApp(home: HomeWidget());
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 50,
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text("PicElementSizeMeasure"),
            ),
            const Center(
              child: Text('aabbcc'),
            ),
          ],
        ),
      ),
    );
  }
}
