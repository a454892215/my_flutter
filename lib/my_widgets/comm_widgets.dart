import 'package:flutter/material.dart';

class RouterButton extends StatelessWidget {
  const RouterButton({super.key, required this.params});

  final List<String> params;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () => Navigator.of(context).pushNamed(params[0]), child: Text(params[1]));
  }
}
