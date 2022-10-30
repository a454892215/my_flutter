typedef OnProgressChangedCallback = void Function(int count, int total);

abstract class HttpInter {
  Future<dynamic> get(String url, dynamic param);

  Future<dynamic> post(String url, dynamic param);

  Future<dynamic> upload(String url, dynamic param, OnProgressChangedCallback callback);

  Future<dynamic> download(String url, dynamic param, String savePath, OnProgressChangedCallback callback);
}
