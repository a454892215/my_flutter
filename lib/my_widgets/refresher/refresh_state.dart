enum RefreshState {
  header_pull_down_load,
  header_release_load,
  header_loading,
  header_load_finished,

  footer_pull_up_load,
  footer_release_load,
  footer_loading,
  footer_load_finished,
}

enum RefresherFunc {
  load_more,
  refresh,
  bouncing,
  no_func,
}
