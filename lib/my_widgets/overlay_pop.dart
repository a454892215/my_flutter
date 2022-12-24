import 'package:flutter/material.dart';

class PopWindow {
  late OverlayEntry entry;
  late BuildContext context;

  void init(BuildContext context) {
    this.context = context;
  }

  void show() {
    entry = OverlayEntry(builder: (context) {
      return Center(
        child: GestureDetector(
          onTap: () {},
          child: Scaffold(
            backgroundColor: Colors.black54,
            body: Center(
              child: GestureDetector(
                onTap: () {
                  dismiss();
                },
                child: Container(
                  width: 300,
                  height: 200,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text("内容"),
                ),
              ),
            ),
          ),
        ),
      );
    });
    Overlay.of(context)?.insert(entry);
  }

  void dismiss() {
    entry.remove();
  }
}
