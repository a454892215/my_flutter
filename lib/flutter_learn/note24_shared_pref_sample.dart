import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/Log.dart';

String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: SharedPreferencesSamplePage(),
  ));
}

class SharedPreferencesSamplePage extends StatefulWidget {
  const SharedPreferencesSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  String _cacheData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreferences"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text("按钮"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: Column(
        //  alignment: Alignment.center,
          children: [
            TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt('counter', 10);
                  await prefs.setBool('repeat', true);
                  await prefs.setDouble('decimal', 1.5);
                  await prefs.setString('action', 'Start');
                  await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
                },
                child: const Text("保存数据")),
            TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final int? counter = prefs.getInt('counter');
                  final bool? repeat = prefs.getBool('repeat');
                  final double? decimal = prefs.getDouble('decimal');
                  final String? action = prefs.getString('action');
                  final List<String>? items = prefs.getStringList('items');
                  setState(() {
                    _cacheData = "$counter  $repeat  $decimal  $action  $items";
                    Log.d("读取的数据是？ $_cacheData");
                  });
                },
                child: const Text("读取数据")),
            TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final success = await prefs.remove('counter');
                  Log.d("删除数据成功？ $success");
                },
                child: const Text("删除数据")),
            Text(_cacheData),
          ],
        ),
      ),
    );
  }
}
