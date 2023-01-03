import 'package:flutter/material.dart';

import '../material_apps.dart';
import '../util/Log.dart';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: RouteAwareTestPage(),
  ));
}

class RouteAwareTestPage extends StatefulWidget {
  const RouteAwareTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<RouteAwareTestPage> with RouteAware {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Log.d("=====didChangeDependencies====== $widget");
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute); //Subscribe it here
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    Log.d('=========didPopNext============');
  }

  @override
  void didPush() {
    Log.d('=========didPush============');
  }

  @override
  void didPop() {
    Log.d('=========didPop============');
  }

  @override
  void didPushNext() {
    Log.d('=========didPushNext============');
  }

  @override
  void dispose() {
    Log.d('=========dispose============');
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Colors.green,
        body: SafeArea(
          child: ListView(
            children: [
              AppBar(
                title: const Text("RouteAwareTestPage"),
              )
            ],
          ),
        ));
  }
}
