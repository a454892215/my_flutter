import 'package:flutter/material.dart';

main() {
  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ProviderSample",
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProviderSample"),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                textStyle: _MyTextStyle(),
                backgroundColor: _MyColorStyle(Colors.grey),
              ),
              child: const Text("按钮1"),
            ),
            TextButton(onPressed: () {}, child: const Text("按钮2")),
            TextButton(onPressed: () {}, child: const Text("按钮3")),
          ],
        ),
      ),
    );
  }
}

class _MyTextStyle extends MaterialStateProperty<TextStyle> {
  @override
  TextStyle resolve(Set<MaterialState> states) {
    return const TextStyle(
      color: Colors.black,
      fontSize: 32,
    );
  }
}

class _MyColorStyle extends MaterialStateProperty<Color> {
  _MyColorStyle(Color color);

  Color color = Colors.white70;

  @override
  Color resolve(Set<MaterialState> states) {
    return const Color.fromARGB(222, 222, 222, 222);
  }
}
