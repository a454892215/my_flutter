import 'package:my_flutter_lib_3/net_work_sample/http_inter.dart';

import 'dio/dio_http.dart';

class HttpUtil implements HttpInter {
  HttpUtil();

  HttpInter http = DioHttp();

  void setHttp(HttpInter http) {
    this.http = http;
  }

  @override
  Future download(String url, param, String savePath, OnProgressChangedCallback callback) async {
    return http.download(url, param, savePath, (count, total) => callback);
  }

  @override
  Future get(String url, param) async {
    return http.get(url, param);
  }

  @override
  Future post(String url, param) async {
    return http.post(url, param);
  }

  @override
  Future upload(String url, param, OnProgressChangedCallback callback) async {
    return http.upload(url, param, (count, total) => callback(count, total));
  }
}
