import 'package:flutter/material.dart';

class CommButton extends StatelessWidget {
  const CommButton({
    super.key,
    this.width = 80,
    this.height = 36,
    required this.onTap,
    this.radius = 0,
    this.bgColor = Colors.grey,
    this.text = "Button",
    this.textColor = Colors.black,
    this.textSize = 20,
    this.selected = false,
    this.selectedBgColor = Colors.blue,
    this.selectedTextColor = Colors.white,
  });

  final double width;
  final double height;
  final double radius;
  final Color bgColor;

  final String text;
  final Color textColor;
  final double textSize;

  final GestureTapCallback onTap;

  final bool selected;
  final Color selectedBgColor;
  final Color selectedTextColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildInk(),
    );
  }

  Widget _buildInk() {
    var bgColor = selected ? selectedBgColor : this.bgColor;
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: InkWell(
            onTap: onTap,
            // splashColor: Colors.grey,
            /// pressed color
           // highlightColor: Colors.blue[700],
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            child: Center(
                child: Text(
              text,
              style: TextStyle(color: textColor),
            ))),
      ),
    );
  }
}
