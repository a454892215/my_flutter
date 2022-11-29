import '../util/Log.dart';

void main() {
  test4();
}

/// future 异步执行验证
test1() {
  getNetworkData().then((value) {
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

/// Future执行完后 回调示例
test2() {
  Future.delayed(new Duration(seconds: 2), () {
    //return "hi world!";
    // throw AssertionError("Error");
  })
      .then((data) {
    //执行成功会走到这里
    print("====then=========");
  }).catchError((e) {
    print("====catchError=========");
    //执行失败会走到这里
    print(e);
  }).whenComplete(() {
    print("====whenComplete=========");
    //无论成功或失败都会走到这里
  });
}

/// Future.wait 示例， 多个future都执行完毕并且成功才返回，只要有一个执行失败就会触发错误回调
test3() {
  Future.wait([
    // 2秒后返回结果
    Future.delayed(const Duration(seconds: 2), () {
      return "hello1";
    }),
    // 4秒后返回结果
    Future.delayed(const Duration(seconds: 4), () {
      return " world2";
    })
  ]).then((results) {
    print(results[0] + results[1]);
  }).catchError((e) {
    print(e);
  });
}

/// Stream示例：可以接收多个异步操作的结果（成功或失败）。 也就是说，在执行异步任务时，
/// 可以通过多次触发成功或失败事件来传递结果数据或错误异常
test4() {
  Stream.fromFutures([
    // 1秒后返回结果
    Future.delayed(const Duration(seconds: 1), () {
      return "hello 1";
    }),
    // 抛出一个异常
    Future.delayed(const Duration(seconds: 2), () {
      throw AssertionError("Error");
    }),
    // 3秒后返回结果
    Future.delayed(const Duration(seconds: 3), () {
      return "hello 3";
    })
  ]).listen((data) {
    // future执行成功回调一次，几个future执行成功回调几次
    print('=====listen=========$data');
  }, onError: (e) {
    // future执行失败回调一次，几个future执行失败回调几次
    print('=====onError=========$e');
  }, onDone: () {
    // 所有future执行完毕后回调一次
    print('====onDone==========');
  });
}
