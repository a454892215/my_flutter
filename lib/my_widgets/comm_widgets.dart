import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../util/Log.dart';

class RouterButton extends StatefulWidget {
  const RouterButton({super.key, required this.params});

  final List<String> params;

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<RouterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffe5e4e4),
      padding: const EdgeInsets.only(top: 4),
      child: MaterialButton(
        onPressed: () => Get.toNamed(widget.params[0]),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: Colors.grey,
        padding: const EdgeInsets.all(0),
        child: Text(widget.params[1]),
      ),
    );
  }

  @override
  void dispose() {
    // Log.d("===========dispose==============");
    super.dispose();
  }
}
