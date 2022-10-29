import 'dart:convert';

import 'package:dio/dio.dart';

import '../../util/Log.dart';

class DioTest {
  /// 使用 "https://localhost" 访问本地https服务器  https正常校验通过，因为自签名证书绑定了 localhost
  /// 为什么使用 https://127.0.0.1 报异常 Hostname mismatch， 自签名证书创建的的时候，已经绑定了/127.0.0.1 地址
  /// 而浏览器能正常访问ssl证书绑定的的域名和IP地址
  static const String baseUrl = "https://localhost.com";

  // static const String baseUrl = "https://127.0.0.1";

  // https://127.0.0.1/test4
  static const String apiTestGet = "/testGet";
  static const String apiTestPost = "/testPost";
  static const String apiTestSendFile = "/testSendFile";

  /// 1. 测试 get 带参数请求
  static void testGetRequest() async {
    try {
      var response = await Dio().get(baseUrl + apiTestGet, queryParameters: {"age": 12, "name": "sandy"});
      Map<dynamic, dynamic> data = json.decode(response.data); // 把json字符串转为map对象
      Log.d("get请求返回：${data.toString()}  name：${data['name']}");
    } catch (e) {
      Log.d(e);
    }
  }
  /// 2. 测试 post 带参数请求
  static void testPostRequest() async {
    try {
      Map<String, dynamic> map = {"age": 12, "name": "sandy"};
      // file 键值不能改
      map['file'] = await MultipartFile.fromFile('images/fjt.jpeg', filename: 'fjt.jpeg') ;
      FormData formData = FormData.fromMap(map);
      var response = await Dio().post(baseUrl + apiTestPost, data: formData);
      Log.d("post请求返回：$response");
    } catch (e) {
      Log.d(e);
    }
  }

  /// 3. 测试 post 带参数和文件上传请求
  static void testFormDataSendFile() async {
    try {
      Map<String, dynamic> map = {"age": 12, "name": "sandy"};
      map['file2'] = await MultipartFile.fromFile('images/fjt.jpeg', filename: 'fjt.jpeg') ;
      FormData formData = FormData.fromMap(map);
      var response = await Dio().post(baseUrl + apiTestSendFile, data: formData);
      Log.d("FormDataSendFile 请求返回：$response");
    } catch (e) {
      Log.d(e);
    }
  }
}

main() {
  DioTest.testGetRequest();
  DioTest.testPostRequest();
  DioTest.testFormDataSendFile();
}
