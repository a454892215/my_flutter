import 'package:flutter/material.dart';

import '../util/Log.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  List<String> picList = [
    "banner1.webp",
    "banner2.webp",
    "banner3.webp",
    "banner4.webp",
  ];

  final Map<int, double> _itemHeights = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 200; i++) {
      var picPath = "images/${picList[i % 4]}";
      _messages.add(Message(content: "$i-Hello", sender: "Alice", pic: picPath));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          return MessageItemWidget(
            message: _messages[index],
            index: index,
            onHeightChanged: (height) {
              _itemHeights[index] = height;
            },
          );
        },
      ),
    );
  }

  void scrollToMessage(int index) {
    double offset = 0.0;
    for (int i = 0; i < index; i++) {
      if (_itemHeights.containsKey(i)) {
        offset += _itemHeights[i] ?? 0;
      }
    }
    _scrollController.jumpTo(offset);
  }
}

class Message {
  final String content;
  final String sender;
  final String pic;

  Message({
    required this.content,
    required this.sender,
    required this.pic,
  });
}

class MessageItemWidget extends StatefulWidget {
  final Message message;
  final int index;
  final Function(double) onHeightChanged;

  const MessageItemWidget({
    Key? key,
    required this.message,
    required this.onHeightChanged,
    required this.index,
  }) : super(key: key);

  @override
  MessageItemState createState() => MessageItemState();
}

class MessageItemState extends State<MessageItemWidget> {
  final GlobalKey globalKey = GlobalKey();
  ImageStream? _imageStream;
  bool _isImageLoaded = false;

  void afterLayout(Duration duration) {
    final RenderObject? object = globalKey.currentContext?.findRenderObject();
    if (object != null) {
      RenderBox renderBox = object as RenderBox;
      final size = renderBox.size;
      Log.d('index:${widget.index} Width: ${size.width}, Height: ${size.height}');
    } else {
      Log.e("object = null currentContext: ${globalKey.currentContext}");
    }
  }

  @override
  void initState() {
    super.initState();
    _imageStream = AssetImage(widget.message.pic).resolve(ImageConfiguration.empty);
    _imageStream!.addListener(ImageStreamListener(_onImageLoaded));
    WidgetsBinding.instance.addPostFrameCallback(afterLayout);
  }

  @override
  void dispose() {
    _imageStream!.removeListener(ImageStreamListener(_onImageLoaded));
    super.dispose();
  }

  void _onImageLoaded(ImageInfo imageInfo, bool synchronousCall) {
    setState(() {
      _isImageLoaded = true;
      var width = imageInfo.image.width;
      var height = imageInfo.image.height;
      Log.d("index：${widget.index}  图片已经加载======width:$width height:$height=======");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKey,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      color: Colors.blue,
      child: Column(
        children: [
          _isImageLoaded ? Image.asset(widget.message.pic):const SizedBox(),
          Text(widget.message.content),
        ],
      ),
    );
  }
}
