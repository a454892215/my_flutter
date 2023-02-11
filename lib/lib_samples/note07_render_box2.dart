import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../util/Log.dart';

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
          color: Colors.grey,
          child: MyLeftGroupWidget(
            children: const [Text("ga-ga-1"), Text("ga-ga-2")],
          ),
        ),
      ),
    );
  }
}

class MyLeftGroupWidget extends MultiChildRenderObjectWidget {
  MyLeftGroupWidget({
    Key? key,
    required List<Widget> children,
  })  : assert(children.length == 2, "只能传两个children"),
        super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderLeftRight();
  }
}

class LeftRightParentData extends ContainerBoxParentData<RenderBox> {}

class RenderLeftRight extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, LeftRightParentData>, RenderBoxContainerDefaultsMixin<RenderBox, LeftRightParentData> {
  // 初始化每一个child的parentData
  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! LeftRightParentData) {
      child.parentData = LeftRightParentData();
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    Log.d("childCount: $childCount   maxWidth:${constraints.maxWidth}");
    RenderBox leftChild = firstChild!;
    LeftRightParentData childParentData = leftChild.parentData! as LeftRightParentData;
    RenderBox rightChild = childParentData.nextSibling!;
    // 我们限制右孩子宽度不超过总宽度一半
    rightChild.layout(constraints.copyWith(maxWidth: constraints.maxWidth / 2), parentUsesSize: true);
    // 调整右子节点的offset
    childParentData = rightChild.parentData! as LeftRightParentData;
    childParentData.offset = Offset(constraints.maxWidth - rightChild.size.width, 0);
    // layout left child
    // 左子节点的offset默认为(0，0)，为了确保左子节点始终能显示，我们不修改它的offset
    leftChild.layout(
        // 左侧剩余的最大宽度
        constraints.copyWith(maxWidth: constraints.maxWidth - rightChild.size.width),
        parentUsesSize: true);
    // 设置LeftRight自身的size
    size = Size(constraints.maxWidth, max(leftChild.size.height, rightChild.size.height));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
