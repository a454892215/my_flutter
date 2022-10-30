import 'package:flutter/material.dart';

import 'dio_http_request_sample.dart';

String summary = '''
''';

void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: _Page(),
  ));
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dio网络请求框架测试-Sample"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text("按钮"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  DioTest().testGetRequest();
                },
                child: const Text("Get 请求测试")),
            TextButton(
                onPressed: () {
                  DioTest().testPostRequest();
                },
                child: const Text("Post 请求测试")),
            TextButton(
                onPressed: () {
                  DioTest().testFormDataSendFile();
                },
                child: const Text("MultiPart/FormData 格式数据请求上传文件测试")),
            TextButton(
                onPressed: () {
                  DioTest().testDownloadFile();
                },
                child: const Text("下载文件测试")),
          ],
        ),
      ),
    );
  }
}
