import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/loading.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: BackdropFilterPage(),
    ),
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
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(12),
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
    );
  }
}
