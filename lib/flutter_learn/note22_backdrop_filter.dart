import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/loading.dart';

void main() {
  runApp(const MaterialApp(
    home: BackdropFilterPage(),
  ));
}

class BackdropFilterPage extends StatefulWidget {
  const BackdropFilterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("高斯模糊背景"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(children: [
              Positioned.fill(
                child: Image.asset("images/fjt.jpeg"),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 32),
                  child: Container(
                    color: const Color(0x80ffffff),
                  ),
                ),
              ),
              const Positioned.fill(
                child: LoadingWidget(),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
