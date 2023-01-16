import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'Log.dart';

class LocalSaveHelper {
  final String fileName;

  LocalSaveHelper(this.fileName);

  Future<File> getFile() async {
    Directory tempDir = await getTemporaryDirectory();
    String filePath = tempDir.path;
    File file = File('$filePath/$fileName');
    bool isExist = await file.exists();
    if (!isExist) {
      file = await file.create();
      isExist = await file.exists();
      Log.d('${file.path} 文件不存在 创建结果：$isExist');
    }
    return file;
  }

  Future<void> saveStr(String content) async {
    File file = await getFile();
    file.writeAsString(content, mode: FileMode.write);
    Log.d('保存内容完毕： length: ${content.length}  path:${file.path}');
  }
}
