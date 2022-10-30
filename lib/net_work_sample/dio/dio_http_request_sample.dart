import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_flutter_lib_3/util/file_dir_util.dart';

import '../../util/Log.dart';
import '../../util/math_util.dart';
import '../test_api.dart';

class DioTest {


  /// 申明隐藏的构造函数
  DioTest._internal() {
    init();
  }

  final Dio _dio = Dio();

  ///  创建单例
  static final DioTest _singleton = DioTest._internal();

  /// 暴露单例，使用factory申明的构造函数 可以使单例像普通对象那样调用
  factory DioTest() {
    return _singleton;
  }

  void init() {
    BaseOptions options = _dio.options;
    options.headers['Access-Control-Allow-Origin'] = '*';

/*    options.headers['Access-Control-Allow-Headers'] = '*';
    options.headers['Access-Control-Allow-Methods'] = '*';
    options.headers['Access-Control-Allow-Credentials'] = 'true';*/
    Log.d("=====init==========${options.headers}");
  }

  /// 1. 测试 get 带参数请求
  void testGetRequest() async {
    try {
      var response = await _dio.get(TestApi.baseUrl + TestApi.apiTestGet, queryParameters: {"age": 12, "name": "sandy"
          ""});
      Map<dynamic, dynamic> data = json.decode(response.data); // 把json字符串转为map对象
      Log.d("get请求返回：${data.toString()}  name：${data['name']}");
    } catch (e) {
      Log.d(e);
    }
  }

  /// 2. 测试 post 带参数请求
  void testPostRequest() async {
    try {
      Map<String, dynamic> map = {"age": 12, "name": "sandy"};
      // file 键值不能改
      map['file'] = await MultipartFile.fromFile('images/fjt.jpeg', filename: 'fjt.jpeg');
      FormData formData = FormData.fromMap(map);
      var response = await _dio.post(TestApi.baseUrl + TestApi.apiTestPost, data: formData);
      Log.d("post请求返回：$response");
    } catch (e) {
      Log.d(e);
    }
  }

  /// 3. 测试 post 带参数和文件上传请求
  void testFormDataSendFile() async {
    try {
      Map<String, dynamic> map = {"age": 12, "name": "sandy"};
      map['file2'] = await MultipartFile.fromFile('images/fjt.jpeg', filename: 'fjt.jpeg');
      FormData formData = FormData.fromMap(map);
      var url = TestApi.baseUrl + TestApi.apiTestSendFile;
      var response = await _dio.post(url, data: formData, onSendProgress: (int count, int total) {
        // double progress = count / total.toDouble();
        // Log.d("上传进度：${MathU.to2D(progress)}");
      });
      Log.d("FormDataSendFile 请求返回：$response");
    } catch (e) {
      Log.d(e);
    }
  }

  /// 4. 测试 下载文件
  void testDownloadFile() async {
    try {
      var saveDir = await FileU.getApkSaveDirPath();
      String savePath = "$saveDir.app";
      var url = TestApi.baseUrl + TestApi.apiTestDownload;
      var response = await _dio.download(url, savePath, onReceiveProgress: (int count, int total) {
        double progress = count / total.toDouble();
        Log.d("Download progress ：${MathU.to2D(progress)}");
      });
      Log.d("testDownloadFile 请求返回：$response");
    } catch (e) {
      Log.d(e);
    }
  }
}

main() {
  DioTest().testGetRequest();
  DioTest().testPostRequest();
  DioTest().testFormDataSendFile();
  DioTest().testDownloadFile();
}
