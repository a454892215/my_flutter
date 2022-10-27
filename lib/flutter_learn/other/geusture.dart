import 'package:flutter/material.dart';

String summary = '''
 * 单击
    onTapDown 指针已经在特定位置与屏幕接触
    onTapUp 指针停止在特定位置与屏幕接触
    onTap 单击事件触发
    onTapCancel 先前指针触发的onTapDown不会在触发单击事件
    
    双击
    onDoubleTap 用户快速连续两次在同一位置轻敲屏幕.
    
    长按
    onLongPress 指针在相同位置长时间保持与屏幕接触
    
    垂直拖拽
    onVerticalDragStart 指针已经与屏幕接触并可能开始垂直移动
    onVerticalDragUpdate 指针与屏幕接触并已沿垂直方向移动.
    onVerticalDragEnd 先前与屏幕接触并垂直移动的指针不再与屏幕接触，并且在停止接触屏幕时以特定速度移动
    
    水平拖拽
    onHorizontalDragStart 指针已经接触到屏幕并可能开始水平移动
    onHorizontalDragUpdate 指针与屏幕接触并已沿水平方向移动
    onHorizontalDragEnd 先前与屏幕接触并水平移动的指针不再与屏幕接触，并在停止接触屏幕时以特定速度移动
''';
void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: _TestWidget(),
    ),
  ));
}

class _TestWidget extends StatefulWidget {
  const _TestWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector();
    });
  }
}
