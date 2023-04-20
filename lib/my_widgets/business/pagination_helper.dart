import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

/// 分页助手： 适用于依据页数分页的请求逻辑
class PaginationHelper {
  int curPageIndex = 0;
  bool isRequestedAllData = false;
  final isAddOnLoadCall = false.obs;
  final int perPageSize;

  final EasyRefreshController easyRefreshController = EasyRefreshController();
  final ScrollController sc = ScrollController();

  PaginationHelper(this.perPageSize);

  Future<void> onRequestDataOk(int itemListSize, {isRefresh = false}) async {
    if (isRefresh) {
      sc.jumpTo(0);
    }
    if (!isRequestedAllData) {
      isRequestedAllData = itemListSize < perPageSize;
      curPageIndex++;

      /// 延迟 保证新的数据渲染完毕 再更新EasyRefresher,
      /// 需要注意的是，当添加onLoad的时候，渲染的数据应该已经超过一个屏幕，否则可能造成onLoad非正常调用
      await Future.delayed(const Duration(milliseconds: 100));
      isAddOnLoadCall.value = !isRequestedAllData;
    }
  }

  int getNextPageIndex() {
    return curPageIndex + 1;
  }

  void onReset() {
    curPageIndex = 0;
    isRequestedAllData = false;
    isAddOnLoadCall.value = false;
  }
}
