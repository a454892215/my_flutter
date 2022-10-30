// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'Log.dart';

main() {
  Log.d("path.current: ${path.current}");
}

class FileU {
  static String defDir = "";

  static Future<String> getApkSaveDirPath() async {
    return await getTemporaryDirectoryPath();
  }

  /// 1. 获取临时目录
  static Future<String> getTemporaryDirectoryPath() async {
    //  Directory directory = await getTemporaryDirectory();
    //  return directory.path;
    return defDir;
  }

  /// 2. 获取app doc目录
  static Future<String> getApplicationDocumentsDirectoryPath() async {
    // Directory directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    return defDir;
  }

  /// 2. 获取web 本地下载目录
  static Future<String> getWebLocalPath() async {
    return path.absolute("build");
  }
}
