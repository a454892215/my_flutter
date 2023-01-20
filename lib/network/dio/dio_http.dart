import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fast_gbk/fast_gbk.dart';

import '../../util/Log.dart';
import '../http_inter.dart';

class DioHttp implements HttpInter {
  DioHttp({this.isGbk = false}) {
    init();
  }

  final Dio _dio = Dio();
  final bool isGbk;

  String gbkDecoder(List<int> responseBytes, RequestOptions options, ResponseBody responseBody) {
    return gbk.decode(responseBytes);
  }

  void init() {
    BaseOptions options = _dio.options;
    options.headers['Access-Control-Allow-Origin'] = '*';
    if (isGbk) {
      options.responseDecoder = gbkDecoder;
    }
    // Log.d("==DioHttp===init==${options.headers}");
  }

  @override
  Future<dynamic> download(String url, param, String savePath, OnProgressChangedCallback callback) async {
    try {
      listener(int count, int total) => callback(count, total);
      return await _dio.download(url, savePath, data: param, onReceiveProgress: listener);
    } catch (e) {
      Log.e("$url $param => $e");
    }
  }

  @override
  Future<dynamic> get(String url, param) async {
    try {
      return await _dio.get(url, queryParameters: param);
      // json.decode(response.data); // 把json字符串转为对象
    } catch (e) {
      Log.e("$url $param => $e");
    }
  }

  @override
  Future<dynamic> post(String url, param) async {
    try {
      return await _dio.post(url, data: param);
      // json.decode(response.data); // 把json字符串转为对象
    } catch (e) {
      Log.e("$url $param => $e");
    }
  }

  @override
  Future<dynamic> upload(String url, param, OnProgressChangedCallback callback) async {
    try {
      listener(int count, int total) => callback(count, total);
      var response = await _dio.post(url, data: param, onSendProgress: listener);
      return json.decode(response.data); // 把json字符串转为对象
    } catch (e) {
      Log.e("$url $param => $e");
    }
  }
}
