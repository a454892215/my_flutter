import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class RouterButton extends StatelessWidget {
  const RouterButton({super.key, required this.params});

  final List<String> params;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffe5e4e4),
      padding: const EdgeInsets.only(top: 4),
      child: MaterialButton(
        onPressed: () => Get.toNamed(params[0]),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: Colors.grey,
        padding: const EdgeInsets.all(0),
        child: Text(params[1]),
      ),
    );
  }
}
