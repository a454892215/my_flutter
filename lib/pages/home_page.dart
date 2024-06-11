import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../env.dart';
import '../my_widgets/comm_widgets.dart';
import '../util/Log.dart';

///Navigator.of(context).pushNamed("/page2"); 这种方式跳转页面是整个页面的跳转

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return Page2State();
  }
}

class Page2State extends State {
  bool isDebug = false;

  final appInfo = ''.obs;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    appInfo.value = await EnvironmentConfig.getAppInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("API用例大全-debug:${Log.isDebugMode()}"),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 217, 216, 216),
        body: Align(
            alignment: Alignment.topCenter,
            child: ListView(
              shrinkWrap: true,
              children:  <Widget>[
                const RouterButton(params: ["/SystemApiSampleListPage", "api用例1"]),
                const RouterButton(params: ["/LibApiSamplesPage", "api用例2"]),
                Obx(() {
                    return Text(
                      appInfo.value,
                        style: const TextStyle(
                          fontSize:15,
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                  }
                ),
              ],
            )));
  }
}
