import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return MyCheckBoxState();
  }
}

class MyCheckBoxState extends State<MyCheckBox> {
  late Image selectedImg;
  late Image unselectedImg;

  @override
  void initState() {
    selectedImg = Image.asset(
      'images/check/ic_checked.png',
      width: 50,
    );
    unselectedImg = Image.asset(
      'images/check/ic_uncheck.png',
      width: 50,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// GestureDetector无点击水波纹效果 InkWell有 。第一次点击会抖动一下？
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _MyChangeNotifier()),
        //  Provider(create: (context) => SomeOtherClass()),
      ],
      child: Consumer<_MyChangeNotifier>(builder: (context, notifier, child) {
        Color curColor = notifier.checked ? Colors.green : Colors.black;
        Image curImage = notifier.checked ? selectedImg : unselectedImg;
        return InkWell(
          child: Column(
            children: [
              curImage,
              Text(
                widget.title,
                style: TextStyle(color: curColor),
              )
            ],
          ),
          onTap: () {
            notifier.setCheck(!notifier.checked);
          },
        );
      }),
    );
  }
}

class _MyChangeNotifier extends ChangeNotifier {
  bool checked = false;

  void setCheck(bool value) {
    checked = value;
    notifyListeners();
  }
}
