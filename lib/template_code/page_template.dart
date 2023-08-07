import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getListView() {
  return ListView.builder(
      itemCount: 20,
      physics: const BouncingScrollPhysics(),
      controller: ScrollController(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: double.infinity,
          height: 50,
          color: index % 2 == 0 ? Colors.blue : Colors.amberAccent,
        );
      });
}

Widget getGridView() {
  return GridView.builder(
    itemCount: 20,
    physics: const BouncingScrollPhysics(),
    controller: ScrollController(),
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.2),
    itemBuilder: (BuildContext context, int index) {
      return Container(
        width: double.infinity,
        height: 50,
        color: index % 2 == 0 ? Colors.blue : Colors.amberAccent,
      );
    },
  );
}

Widget getColumn() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "",
        style: TextStyle(
          fontSize: 24.w,
          color: const Color(0xffcccccc),
          fontWeight: FontWeight.w400,
        ),
      )
    ],
  );
}

Widget getRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "",
        style: TextStyle(
          fontSize: 24.w,
          color: const Color(0xffcccccc),
          fontWeight: FontWeight.w400,
        ),
      )
    ],
  );
}

Widget getContainer() {
  return Container(
    width: 100.w,
    height: 100.w,
    decoration: const BoxDecoration(color: Color(0xffcccccc)),
    child: SizedBox(),
  );
}

Widget getText() {
  return Text(
    "",
    style: TextStyle(
      fontSize: 24.w,
      color: const Color(0xffcccccc),
      fontWeight: FontWeight.w400,
    ),
  );
}

Widget getImage() {
  return Image.asset("", width: 60.w);
}

Widget getPositioned() {
  return Positioned(
    right: 0.w,
    left: 0.w,
    child: SizedBox(),
  );
}

Widget getPageView() {
  return PageView.builder(
    itemCount: 3,
    physics: const BouncingScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return Container(
        width: 100.w,
        height: 100.w,
        decoration: const BoxDecoration(color: Color(0xffcccccc)),
        child: const SizedBox(),
      );
    },
  );
}
