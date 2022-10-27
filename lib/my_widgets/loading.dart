import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("LoadingWidget"),
      ),
      body: const LoadingWidget(),
    ),
  ));
}

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

bool _enable = true;

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return _enable ? buildContainer() : const SizedBox(width: 0, height: 0);
  }

  Widget buildContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0x44000000),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CupertinoActivityIndicator(),
          SizedBox(width: 12),
          Text("Loading..."),
        ],
      ),
    );
  }
}
