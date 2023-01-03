import 'package:flutter/material.dart';

import '../material_apps.dart';

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
    print("=====didChangeDependencies====== $widget");
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute); //Subscribe it here
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    print('=========didPopNext============');
  }

  @override
  void didPush() {
    print('=========didPush============');
  }

  @override
  void didPop() {
    print('=========didPop============');
  }

  @override
  void didPushNext() {
    print('=========didPushNext============');
  }

  @override
  void dispose() {
    print('=========dispose============');
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xffff9ef0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [],
        ),
      ),
    );
  }
}
