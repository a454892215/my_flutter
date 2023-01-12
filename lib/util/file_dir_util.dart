import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as my_path;
import 'package:path_provider/path_provider.dart';
main() {}

bool isWeb() {
  return kIsWeb == true;
}

class FileU {

  static Future<dynamic> getApkSaveDirPath() async {
    return getTemporaryDirectoryPath();
  }

  /// 1. 获取临时目录
  static Future<dynamic> getTemporaryDirectoryPath() async {
    if (isWeb()) {
      return getWebLocalPath();
    } else {
      return getTemporaryDirectory();
    }
  }

  /// 2. 获取app doc目录
  static Future<dynamic> getApplicationDocumentsDirectoryPath() async {
    if (isWeb()) {
      return getWebLocalPath();
    } else {
      return getApplicationDocumentsDirectory();
    }
  }

  /// 2. 获取web 本地下载目录
  static Future<String> getWebLocalPath() async {
    return my_path.absolute("build${my_path.separator}");
  }

}
