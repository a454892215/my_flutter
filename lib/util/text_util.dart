import 'package:flutter/cupertino.dart';

import 'Log.dart';

void measureText({
  required String text,
  required double maxWidth,
  required TextStyle style,
}) {
  TextSpan span = TextSpan(style: style, text: text);
  TextPainter painter = TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
  painter.layout(maxWidth: 200);
  double textHeight = painter.height;
  double textWidth = painter.width;
  int lines = painter.computeLineMetrics().length;
  Log.d("textWidth:$textWidth  textHeight:$textHeight - lines:$lines");
}
