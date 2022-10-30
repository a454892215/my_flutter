import 'dart:convert';

import 'package:dio/dio.dart';

import '../../util/Log.dart';
import '../http_inter.dart';

class DioHttp implements HttpInter {
  DioHttp() {
    init();
  }

  final Dio _dio = Dio();

  void init() {
    BaseOptions options = _dio.options;
    options.headers['Access-Control-Allow-Origin'] = '*';
    Log.d("==DioHttp===init==${options.headers}");
  }

  @override
  Future<dynamic> download(String url, param, String savePath, OnProgressChangedCallback callback) async {
    try {
      listener(int count, int total) => callback(count, total);
      return await _dio.download(url, savePath, data: param, onReceiveProgress: listener);
    } catch (e) {
      Log.d(e);
    }
  }

  @override
  Future<dynamic> get(String url, param) async {
    try {
      var response = await _dio.get(url, queryParameters: param);
      return json.decode(response.data); // 把json字符串转为对象
    } catch (e) {
      Log.d(e);
    }
  }

  @override
  Future<dynamic> post(String url, param) async {
    try {
      var response = await _dio.post(url, data: param);
      return json.decode(response.data); // 把json字符串转为对象
    } catch (e) {
      Log.d(e);
    }
  }

  @override
  Future<dynamic> upload(String url, param, OnProgressChangedCallback callback) async {
    try {
      listener(int count, int total) => callback(count, total);
      var response = await _dio.post(url, data: param, onSendProgress: listener);
      return json.decode(response.data); // 把json字符串转为对象
    } catch (e) {
      Log.d(e);
    }
  }
}
