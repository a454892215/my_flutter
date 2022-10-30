class TestApi {
  /// 使用 "https://localhost" 访问本地https服务器  https正常校验通过，因为自签名证书绑定了 localhost
  /// 为什么使用 https://127.0.0.1 报异常 Hostname mismatch， 自签名证书创建的的时候，已经绑定了/127.0.0.1 地址
  /// 而浏览器能正常访问ssl证书绑定的的域名和IP地址
  static const String baseUrl = "https://localhost";
 // static const String baseUrl = "https://localhost.com";

  // static const String baseUrl = "https://127.0.0.1";

  // https://127.0.0.1/test4
  static const String apiTestGet = "/testGet";
  static const String apiTestPost = "/testPost";
  static const String apiTestSendFile = "/testSendFile";
  static const String apiTestDownload = "/testDownload";
}
