import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State {
  ThemeData darkTheme = ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark);

  void onSwitchTheme(int type) {
    setState(() {
      if (type == 1) {
        darkTheme = ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light);
      } else {
        darkTheme = ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "theme selector",
      theme: darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("theme-selector"),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    onSwitchTheme(2);
                  },
                  child: const Text("dark")),
              ElevatedButton(
                  onPressed: () {
                    onSwitchTheme(1);
                  },
                  child: const Text("light")),
            ],
          ),
        ),
      ),
    );
  }
}
