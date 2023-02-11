import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../util/Log.dart';

/// SingleChildRenderObjectWidget， RenderShiftedBox 用法示例
class RenderBoxPage1 extends StatefulWidget {
  const RenderBoxPage1({super.key});

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
        title: const Text("RenderShiftedBox-示例"),
      ),
      body: Align(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.grey,
          child: const MyCenterWidget(
            child: Text("ga-ga"),
          ),
        ),
      ),
    );
  }
}

class MyCenterWidget extends SingleChildRenderObjectWidget {
  const MyCenterWidget({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCenteredBox();
  }
}

class RenderCenteredBox extends RenderShiftedBox {
  RenderCenteredBox({RenderBox? child}) : super(child);

  @override
  void performLayout() {
    //1. 先对子组件进行layout，随后获取它的size
    child!.layout(
      constraints.loosen(), //将约束传递给子节点
      parentUsesSize: true, // 因为我们接下来要使用child的size,所以不能为false
    );
    // 2.根据子组件的大小, 和自身最大大小 确定自身的大小
    // Log.d("mySize==== 1 : $size"); // RenderBox was not laid out 异常
    size = constraints.constrain(Size(
      constraints.maxWidth == double.infinity ? child!.size.width : constraints.maxWidth,
      constraints.maxHeight == double.infinity ? child!.size.height : constraints.maxHeight,
    ));
    Log.d("childSize: ${child!.size}");
    Log.d("mySize==== 2 : $size   maxWidth:${constraints.maxWidth}");

    // 3. 根据父节点子节点的大小，算出子节点在父节点中居中之后的偏移，然后将这个偏移保存在
    // 子节点的parentData中，在后续的绘制阶段，会用到。
    BoxParentData parentData = child!.parentData as BoxParentData;
    parentData.offset = ((size - child!.size) as Offset) / 2;
  }
}
