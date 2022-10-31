import 'package:flutter/material.dart';

class RouterButton extends StatelessWidget {
  const RouterButton({super.key, required this.params});

  final List<String> params;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: const EdgeInsets.only(top: 4),
      child: MaterialButton(
        onPressed: () => Navigator.of(context).pushNamed(params[0]),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: Colors.green,
        padding: const EdgeInsets.all(0),
        child: Text(params[1]),
      ),
    );
  }
}
