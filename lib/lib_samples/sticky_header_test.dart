import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../my_widgets/chat/chat_painter.dart';
import '../my_widgets/chat/entities.dart';
import '../util/Log.dart';

class StickerHeaderWidget extends StatefulWidget {
  const StickerHeaderWidget({Key? key}) : super(key: key);

  @override
  ChatRoomTestWidgetState createState() => ChatRoomTestWidgetState();
}

ScrollController scrollController = ScrollController();
ListObserverController observerController = ListObserverController(controller: scrollController);

class ChatRoomTestWidgetState extends State<StickerHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("sticky header test"),
        ),
        body: CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, i) => ListTile(
                leading: const CircleAvatar(
                  child: Text('0'),
                ),
                title: Text('List tile #$i'),
              ),
              childCount: 8,
            ),
          ),
          SliverStickyHeaderWidget(),
          SliverStickyHeaderWidget(),
          SliverStickyHeaderWidget(),
          SliverStickyHeaderWidget(),
        ],));
  }
}

class SliverStickyHeaderWidget extends StatelessWidget {
  const SliverStickyHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader.builder(
      builder: (context, state) => Container(
        height: 60.0,
        color: (state.isPinned ? Colors.lightBlue : Colors.lightBlue)
            .withOpacity(1.0 - state.scrollPercentage),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: const Text(
          'Header #1',
          style: TextStyle(color: Colors.white),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, i) => ListTile(
            leading: const CircleAvatar(
              child: Text('0'),
            ),
            title: Text('List tile #$i'),
          ),
          childCount: 8,
        ),
      ),
    );
  }
}
