import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_flutter_lib_3/network/http_request.dart';

import '../../encode/gbk/convert.dart';
import '../../network/dio/dio_http.dart';
import '../../util/Log.dart';

class WebParserController extends GetxController {
  // String url = 'https://woowoowoo.xyz/?u=http://01bz.fans/16/16486/650418.html&p=/16/16486/650418.html';
  String url = 'http://www.tz659.com';

  @override
  Future<void> onReady() async {
    super.onReady();
    request(url);
  }

  Future<void> request(String url) async {
    Log.d("==========开始请求数据==========");
    HttpUtil httpUtil = HttpUtil(httpInter: DioHttp());
    Response<dynamic> response = await httpUtil.get(url, null);
    var statusCode = response.statusCode;
    String data = response.data;
    GbkEncoder gbkEncoder = const GbkEncoder();
    List<int> byte = gbkEncoder.convert(data);
    GbkDecoder gbkDecoder = const GbkDecoder();
    data = gbkDecoder.convert(byte);
    Log.d("statusCode:$statusCode    data:$data ");
  }
}
