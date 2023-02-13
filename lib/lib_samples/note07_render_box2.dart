import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../util/Log.dart';
import '../util/math_util.dart';

/// SingleChildRenderObjectWidget， RenderShiftedBox 用法示例
class RenderBoxPage2 extends StatefulWidget {
  const RenderBoxPage2({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MultiChildRenderBox-示例"),
      ),
      body: Align(
        child: Container(
          width: 300,
          height: 200,
          color: Colors.yellow,
          child: Align(
            alignment: Alignment.topLeft,
            child: MyLeftRightGroupWidget(
              children: const [Text("ga-ga-1"), Text("ga-ga-2"), Text("ga-ga-2")],
            ),
          ),
        ),
      ),
    );
  }
}

class MyLeftRightGroupWidget extends MultiChildRenderObjectWidget {
  MyLeftRightGroupWidget({
    Key? key,
    required List<Widget> children,
  })  :
        super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderLeftRight();
  }
}

class LeftRightParentData extends ContainerBoxParentData<RenderBox> {}

class RenderLeftRight extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, LeftRightParentData>, RenderBoxContainerDefaultsMixin<RenderBox, LeftRightParentData> {
  /// 0.初始化每一个child的parentData
  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! LeftRightParentData) {
      child.parentData = LeftRightParentData();
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    Log.d("performLayout childCount: $childCount   maxWidth:${constraints.maxWidth}");
    List<RenderBox> childList = getChildrenAsList();
    Log.d(":");
    RenderBox leftChild = childList[0];

    /// 1. 对子组件进行layout, 测量出其大小
    leftChild.layout(constraints.loosen(), parentUsesSize: true);
    LeftRightParentData child0ParentData = leftChild.parentData! as LeftRightParentData;

    /// 2. 设置子组件的位置
    child0ParentData.offset = const Offset(0, 0);

    RenderBox rightChild = child0ParentData.nextSibling!;
    rightChild.layout(constraints.loosen(), parentUsesSize: true);
    LeftRightParentData child1ParentData = rightChild.parentData! as LeftRightParentData;
    child1ParentData.offset = Offset(constraints.maxWidth - rightChild.size.width, 0);

    /// 3. 设置自己的大小
    Size tempSize = Size(constraints.maxWidth, max(leftChild.size.height, rightChild.size.height));
    if (constraints.isSatisfiedBy(tempSize)) {
      size = tempSize;
    } else {
      Log.e("size 约束异常... ");
      var height = max(leftChild.size.height, rightChild.size.height);
      size = Size(constraints.maxWidth, MathU.clamp(height, constraints.minHeight, constraints.maxHeight));
    }
  }

  final Paint _paint = Paint();

  @override
  void paint(PaintingContext context, Offset offset) {
    Log.d("paint: size: $size  offset:$offset");
    drawBg(context, offset, Colors.blue);
    defaultPaint(context, offset);
  }

  /// 绘制背景颜色
  void drawBg(PaintingContext context, Offset offset, Color bgColor) {
    _paint.style = PaintingStyle.fill;
    _paint.color = bgColor;
    context.canvas.drawRect(Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height), _paint);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
