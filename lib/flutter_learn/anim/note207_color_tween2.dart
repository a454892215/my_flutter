import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/my_widgets/comm_anim.dart';

main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: ColorTweenSample2(),
    ),
  ));
}

///1. ColorTween
class ColorTweenSample2 extends StatefulWidget {
  const ColorTweenSample2({Key? key}) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State with TickerProviderStateMixin {
  late CommonColorAnim colorAnim = CommonColorAnim(onColorUpdate, 250, const Color(0xffff0000), const Color(0x66ff0000), this);

  void onColorUpdate(Color color) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        colorAnim.reverseNow();
      },
      onTapDown: (_) {
        colorAnim.start();
      },
      child: Center(
        child: Container(
          width: 150,
          height: 150,
          color: colorAnim.getColor(),
          alignment: Alignment.center,
          child: const Text(
            "ColorTween",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
