import 'package:flutter/material.dart';

class ImageText extends StatefulWidget {
  const ImageText(
      {super.key,
        this.imageUri,
        required this.imageWidth,
        required this.text,
        required this.fontSize,
        required this.textColor,
        required this.onClick,
        this.padding = 10,
        this.borderRadius = BorderRadius.zero,
        this.axis = Axis.horizontal,
        this.bgColor});

  final String? imageUri;
  final double imageWidth;
  final String text;
  final double fontSize;
  final Color textColor;
  final double padding;
  final Color? bgColor;
  final Axis axis;
  final BorderRadius borderRadius;
  final VoidCallback onClick;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ImageText> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: Material(
        color: widget.bgColor,
        child: InkWell(
          onTap: widget.onClick,
          child: Center(
            child: Flex(
              mainAxisSize: MainAxisSize.min,
              direction: widget.axis,
              children: [
                widget.imageUri == null ? const SizedBox(width: 0, height: 0) : Image.asset(widget.imageUri!, width: widget.imageWidth),
                SizedBox(width: widget.padding, height: widget.padding),
                Text(widget.text, style: TextStyle(fontSize: widget.fontSize, color: widget.textColor))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
