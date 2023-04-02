
import 'package:flutter/cupertino.dart';


class InputErrHintWidget extends StatelessWidget {
  final String errText;
  final bool isHidden;
  final double heightOnHidden;
  final double paddingTop;
  final double paddingBot;

   const InputErrHintWidget({
    super.key,
    required this.errText,
    required this.isHidden,
    required this.heightOnHidden,
    this.paddingTop = 0,
    this.paddingBot = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Offstage(
          offstage: isHidden,
          child: Container(
            padding: EdgeInsets.only(top: paddingTop, bottom: paddingBot),
            alignment: Alignment.centerLeft,
            child: Text(
              errText,
              style: const TextStyle(fontSize: 13, color: Color(0xffDC2326)),
            ),
          ),
        ),
        SizedBox(height: isHidden ? heightOnHidden : 0)
      ],
    );
  }
}
