
import '../util/Log.dart';

void main(){
  getNetworkData().then((value){
    Log.d("value: $value");
  });
  /// 1. 这里没有被阻塞 优先222执行
  Log.d("===========333==============");
}
Future<String> getNetworkData() async {
  Log.d("=========111==========:${DateTime.now()}");
  var result = await Future.delayed(const Duration(seconds: 3), () {
    return "network data";
  });
  Log.d("=========222==========:${DateTime.now()}");
  return "请求到的数据：$result";
}
