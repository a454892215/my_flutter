class RefresherParam{
   double headerOrFooterHeight = 250; /// 头部和脚部高度需要相同
   double headerIndicatorHeight = 60;
   double footerIndicatorHeight = 60;
   double footerTriggerRefreshDistance = 60;

   late double loadingPosOfHeader = headerOrFooterHeight - headerIndicatorHeight;
   late double loadingPosOfFooter = headerOrFooterHeight + headerIndicatorHeight;
   late double maxScrollDistanceToLoading = headerOrFooterHeight - footerIndicatorHeight;
   /// 加载结束后，瞬时偏移量，使部分新内容自然显示出来
   double loadFinishOffset = 0;


}