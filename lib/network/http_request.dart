import 'dio/dio_http.dart';
import 'http_inter.dart';

class HttpUtil implements HttpInter {
  HttpUtil({HttpInter? httpInter}) {
    setHttp(httpInter ?? DioHttp());
  }

  late HttpInter http;

  void setHttp(HttpInter http) {
    this.http = http;
  }

  @override
  Future<dynamic> download(String url, param, String savePath, OnProgressChangedCallback callback) async {
    return http.download(url, param, savePath, (count, total) => callback);
  }

  @override
  Future<dynamic> get(String url, param) async {
    return http.get(url, param);
  }

  @override
  Future<dynamic> post(String url, param) async {
    return http.post(url, param);
  }

  @override
  Future<dynamic> upload(String url, param, OnProgressChangedCallback callback) async {
    return http.upload(url, param, (count, total) => callback(count, total));
  }
}
