import 'package:flutter/material.dart';
import 'package:screen_capture_event/screen_capture_event.dart';

import '../util/Log.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: ScreenShotEventSamplePage(),
  ));
}

class ScreenShotEventSamplePage extends StatefulWidget {
  const ScreenShotEventSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State {
  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final ScreenCaptureEvent screenListener = ScreenCaptureEvent();
  String text = '';

  @override
  void initState() {
    super.initState();
    /// 录屏监听
    screenListener.addScreenRecordListener((recorded) {
      setState(() {
        text = recorded ? "Start Recording" : "Stop Recording";
        Log.d("发生录屏：$recorded");
      });
    });

    /// 截屏监听
    screenListener.addScreenShotListener((filePath) {
      setState(() {
        text = "Screenshot stored on : $filePath"; //filePath only available for Android
        Log.d("发生截屏：$filePath");
      });
    });

    screenListener.watch();

    ///Start watch
    super.initState();
  }

  @override
  void dispose() {
    screenListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children:  [
          Container(
            height: 50,
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text("ScreenShotEventSamplePage"),
          ),
          Center(child: Text(text),),
        ],
      )),
    );
  }
}
