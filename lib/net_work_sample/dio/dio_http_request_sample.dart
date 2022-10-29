import 'package:dio/dio.dart';

class DioTest {
  /// 使用 "https://localhost" 访问本地https服务器  https正常校验通过，因为自签名证书绑定了 localhost
   static const String baseUrl = "https://localhost.com";
  /// 为什么使用 https://127.0.0.1 报异常 CERTIFICATE_VERIFY_FAILED: Hostname mismatch
  /// 自签名证书创建的的时候，已经绑定了/127.0.0.1地址了呀？ 而浏览器都能正常访问 "https://127.0.0.1"
   ///  mkcert自定义非 localhost 域名, 浏览器访问失败，但是flutter却能访问成功，自定义域名的IP地址浏览器访问成功，flutter访问失败
//  static const String baseUrl = "https://127.0.0.1";

  // https://127.0.0.1/test4
  static const String apiTest4 = "/test4";

  static void getHttp() async {
    try {
      var response = await Dio().get(baseUrl + apiTest4);

      print(response);
    } catch (e) {
      print(e);
    }
  }
}

main() {
  DioTest.getHttp();
}
