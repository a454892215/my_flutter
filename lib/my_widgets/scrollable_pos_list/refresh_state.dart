enum RefreshState {
  def,
  header_release_load,
  header_loading,
  header_load_finished,
  header_all_data_load_finished,

  footer_release_load,
  footer_loading,
  footer_load_finished,
  footer_all_data_load_finished,
}

enum RefresherFunc {
  load_more,
  refresh,
  bouncing,
  no_func,
}
