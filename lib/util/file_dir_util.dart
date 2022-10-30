// import 'dart:io';

// import 'package:path_provider/path_provider.dart';

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
}
