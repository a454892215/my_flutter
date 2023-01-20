import 'package:package_info_plus/package_info_plus.dart';

class EnvironmentConfig {
  static const APP_CHANNEL = String.fromEnvironment('APP_CHANNEL');
  static const APP_ENV = String.fromEnvironment('APP_ENV');

  static bool isDebug() {
    return EnvironmentConfig.APP_ENV == 'debug';
  }

  static String getEnvInfo() {
    return '环境配置： APP_ENV:$APP_ENV  isDebug:${isDebug()}  APP_CHANNEL: $APP_CHANNEL';
  }

  static Future<String> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNum = packageInfo.buildNumber;
    return " appName:$appName  packageName:$packageName  version:$version  buildNum:$buildNum";
  }
}
