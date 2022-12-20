import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static void show(Object msg) {
    toast(msg);
  }

  static void toast(Object msg) {
    Fluttertoast.showToast(
        msg: msg.toString(), gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
  }
}

void toast(Object msg) {
  Fluttertoast.showToast(
      msg: msg.toString(), gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
}
