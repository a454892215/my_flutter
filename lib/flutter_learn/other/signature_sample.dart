import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_flutter_lib_3/util/Log.dart';
import 'package:signature/signature.dart';

String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: _Page(),
  ));
}

/// 1. 第三方签名组件 signature: ^5.2.1
class _Page extends StatefulWidget {
  const _Page();

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  final SignatureController _signatureController = SignatureController(
    penColor: Colors.blue,
    penStrokeWidth: 3,
  );
  Uint8List? uint8list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //  var future = _signatureController.toImage(width: 300, height: 300);
          var pngBytes = _signatureController.toPngBytes();
          pngBytes.then((value) {
            if (value != null) {
              uint8list = value;
              Log.d("type====：${value.runtimeType}");
              setState(() {});
            }
          });
        },
        child: const Text("按钮"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Signature(
              controller: _signatureController,
              backgroundColor: Colors.white,
              width: 240,
              height: 120,
            ),
            uint8list == null
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.only(top: 12),
                    color: Colors.white,
                    child: Image.memory(
                      uint8list!,
                      isAntiAlias: true,
                      filterQuality: FilterQuality.high,
                      gaplessPlayback: true,
                      width: 240,
                      height: 120,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
