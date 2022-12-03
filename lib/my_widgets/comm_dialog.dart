import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 底部统一标题弹窗

/// 底部弹窗
void bottomDialog({
  bool? back,
  double? elevation,
  Color? barrierColor,
  required Widget child,
}) {
  Get.bottomSheet(
    WillPopScope(
      onWillPop: () async => back ?? true,
      child: child,
    ),
    barrierColor:barrierColor ?? Colors.black54,
    elevation: elevation ?? 0,
    isScrollControlled: false,
  );
}