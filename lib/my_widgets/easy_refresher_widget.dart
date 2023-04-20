import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'business/pagination_helper.dart';

class EasyRefreshWidget extends StatelessWidget {
  final PaginationHelper paginationHelper;
  final OnRefreshCallback? onRefreshCallback;
  final OnLoadCallback? onLoadCallback;
  final List<Widget>? slivers;

  const EasyRefreshWidget({
    super.key,
    required this.paginationHelper,
    required this.onRefreshCallback,
    required this.onLoadCallback,
    required this.slivers,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Widget child = EasyRefresh.custom(
        controller: paginationHelper.easyRefreshController,
        scrollController: paginationHelper.sc,
        header: ClassicalHeader(),
        enableControlFinishLoad: true,
        enableControlFinishRefresh: true,
        taskIndependence: true,
        footer: paginationHelper.isAddOnLoadCall.value ? ClassicalFooter() : null,
        onRefresh: onRefreshCallback,
        onLoad: paginationHelper.isAddOnLoadCall.value ? onLoadCallback : null,
        bottomBouncing: !paginationHelper.isAddOnLoadCall.value,
        slivers: slivers,
      );
      return child;
    });
  }
}
