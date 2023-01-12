import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as my_path;

main() {

}

class FileU {
  static String defDir = "";

  static Future<Directory> getApkSaveDirPath() async {
    return getTemporaryDirectoryPath();
  }

  /// 1. 获取临时目录
  static Future<Directory> getTemporaryDirectoryPath() async {
      return getTemporaryDirectory();
  }

  /// 2. 获取app doc目录
  static Future<String> getApplicationDocumentsDirectoryPath() async {
    // Directory directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    return defDir;
  }

  /// 2. 获取web 本地下载目录
  static Future<String> getWebLocalPath() async {
    return my_path.absolute("build${my_path.separator}");
  }
}
