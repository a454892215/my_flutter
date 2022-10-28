import 'package:flutter/material.dart';

String summary = '''
1. ShaderMask 示例
''';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: _Page(),
  ));
}

/// ShaderMask
class _Page extends StatefulWidget {
  const _Page();

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text("按钮"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: Column(
          children: [
            Column(
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(colors: [
                      Colors.yellow,
                      Colors.red,
                      Colors.blue,
                    ]).createShader(bounds);
                  },
                  child: Image.asset(
                    "images/fjt.jpeg",
                    width: 160,
                  ),
                ),
                const SizedBox(height: 12),
                Image.asset(
                  "images/fjt.jpeg",
                  width: 160,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
