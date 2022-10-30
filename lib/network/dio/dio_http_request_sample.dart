import 'package:dio/dio.dart';
import 'package:my_flutter_lib_3/util/file_dir_util.dart';

import '../../util/Log.dart';
import '../../util/math_util.dart';
import '../http_inter.dart';
import '../test_api.dart';
import 'dio_http.dart';

class DioTest {
  final HttpInter http = DioHttp();

  /// 1. 测试 get 带参数请求
  void testGetRequest() async {
    try {
      var param = {"age": 12, "name": "sandy"};
      var path = TestApi.baseUrl + TestApi.apiTestGet;
      var data = await http.get(path, param);
      Log.d("Get 请求返回：${data.toString()}");
    } catch (e) {
      Log.d(e);
    }
  }

  /// 2. 测试 post 带参数请求
  void testPostRequest() async {
    try {
      Map<String, dynamic> map = {"age": 12, "name": "sandy"};
      map['file'] = await MultipartFile.fromFile('images/fjt.jpeg', filename: 'fjt.jpeg');
      FormData formData = FormData.fromMap(map);
      var data = await http.post(TestApi.baseUrl + TestApi.apiTestPost, formData);
      Log.d("Post 请求返回：${data.toString()}");
    } catch (e) {
      Log.d(e);
    }
  }

  /// 3. 测试 post 带参数和文件上传请求
  void testFormDataSendFile() async {
    try {
      Map<String, dynamic> map = {"age": 12, "name": "sandy"};
      map['file'] = await MultipartFile.fromFile('images/fjt.jpeg', filename: 'fjt.jpeg');
      FormData formData = FormData.fromMap(map);
      var url = TestApi.baseUrl + TestApi.apiTestSendFile;
      var data = await http.upload(url, formData, (int count, int total) {});
      Log.d("FormDataSendFile 上传文件成功 请求返回：${data.toString()}");
    } catch (e) {
      Log.d(e);
    }
  }

  /// 4. 测试 下载文件
  void testDownloadFile() async {
    try {
      String saveDir = await FileU.getWebLocalPath();
      String saveFullPath = "${saveDir}downloadFile.app";
      Log.d('saveFullPath: $saveFullPath');
      var url = TestApi.baseUrl + TestApi.apiTestDownload;
      Response<ResponseBody> response = await http.download(url, null, saveFullPath, (int count, int total) {
        /*double progress = count / total.toDouble();
        Log.d("Download progress ：${MathU.to2D(progress)}");*/
      });
      Log.d("testDownloadFile 下载成功 statusCode：${response.statusCode} 文件路径：$saveFullPath");
    } catch (e) {
      Log.d(e);
    }
  }
}

main() {
  DioTest dioTest = DioTest();
  dioTest.testGetRequest();
  dioTest.testPostRequest();
  dioTest.testFormDataSendFile();
  DioTest().testDownloadFile();
}
