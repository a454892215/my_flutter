import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

class CommButton extends StatelessWidget {
  const CommButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Color(0xffe5e5e5), Color(0xff969696), Color(0xffe5e5e5)])),
      child: MaterialButton(
        onPressed: () => onPressed(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(0),
        child: Text(text),
      ),
    );
  }
}
