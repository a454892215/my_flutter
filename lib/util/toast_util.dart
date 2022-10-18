import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Toast {
  static void toast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
