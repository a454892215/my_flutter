import 'package:package_by_walle/package_by_walle.dart';
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

    // 获取渠道号
    String channel = await PackageByWalle.getPackingChannel ?? "test";

// 获取额外打包参数（configFile文件中配置）
    Map? info = await PackageByWalle.getPackingInfo;
    return " appName:$appName  packageName:$packageName  version:$version  buildNum:$buildNum  channel:$channel info:$info";
  }
}
