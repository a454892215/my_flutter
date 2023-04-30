class RefresherParam{
   double headerHeight = 250;
   double headerIndicatorHeight = 60;
   double headerTriggerRefreshDistance = 60;
   late double loadingPos = headerHeight - headerTriggerRefreshDistance;
   /// 加载结束后，瞬时偏移量，使部分新内容自然显示出来
   double loadFinishOffset = 0;

   double footerHeight = 180;
   double footerIndicatorHeight = 60;
   double footerTriggerRefreshDistance = 60;
}