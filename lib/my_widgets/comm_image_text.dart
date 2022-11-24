import 'package:flutter/cupertino.dart';

class ImageText extends StatefulWidget {
  const ImageText(
      {super.key,
      required this.imageUri,
      required this.imageWidth,
      required this.text,
      required this.fontSize,
      required this.textColor,
      required this.padding,
      this.axis = Axis.horizontal,
      this.bgColor});

  final String imageUri;
  final double imageWidth;
  final String text;
  final double fontSize;
  final Color textColor;
  final double padding;
  final Color? bgColor;
  final Axis axis;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ImageText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: widget.bgColor,
      child: Flex(
        mainAxisSize: MainAxisSize.min,
        direction: widget.axis,
        children: [
          Image.asset(
            widget.imageUri,
            width: widget.imageWidth,
          ),
          SizedBox(width: widget.padding, height: widget.padding),
          Text(
            widget.text,
            style: TextStyle(fontSize: widget.fontSize, color: widget.textColor),
          )
        ],
      ),
    );
  }
}
